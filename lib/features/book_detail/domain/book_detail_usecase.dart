import 'package:bookish_invention/features/book_detail/domain/book_detail_entity.dart';
import 'package:bookish_invention/features/book_detail/domain/book_detail_ui_output.dart';
import 'package:bookish_invention/features/book_detail/external_interface/book_detail_gateway.dart';
import 'package:clean_framework/clean_framework.dart';

class BookDetailUseCase extends UseCase<BookDetailEntity> {
  BookDetailUseCase()
      : super(
          entity: const BookDetailEntity(),
          transformers: [BrowseBooksUIOutputTransformer()],
        );

  Future<void> fetchBookDetail(String bookId) async {
    entity = entity.copyWith(
      status: BookDetailStatus.loading,
    );

    try {
      await request<BookDetailGatewayOutput, BookDetailSuccessInput>(
        BookDetailGatewayOutput(bookId),
        onSuccess: (success) {
          return entity.copyWith(
            status: BookDetailStatus.loaded,
            bookDetail: success.bookDetail,
          );
        },
        onFailure: (failure) {
          return entity.copyWith(status: BookDetailStatus.error);
        },
      );
    } catch (_) {
      entity = entity.copyWith(status: BookDetailStatus.error);
    }
  }
}

class BrowseBooksUIOutputTransformer
    extends OutputTransformer<BookDetailEntity, BookDetailUIOutput> {
  @override
  BookDetailUIOutput transform(BookDetailEntity entity) {
    return BookDetailUIOutput(status: entity.status, bookDetailModel: entity.bookDetail);
  }
}
