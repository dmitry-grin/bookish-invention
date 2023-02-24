import 'package:bookish_invention/features/browse_books/domain/browse_books_entity.dart';
import 'package:bookish_invention/features/browse_books/domain/browse_books_ui_output.dart';
import 'package:bookish_invention/features/browse_books/external_interface/my_books_gateway.dart';
import 'package:bookish_invention/features/browse_books/models/book_model.dart';
import 'package:clean_framework/clean_framework.dart';

class BrowseBooksUseCase extends UseCase<BrowseBooksEntity> {
  BrowseBooksUseCase()
      : super(
          entity: const BrowseBooksEntity(),
          transformers: [BrowseBooksUIOutputTransformer()],
        );

  Future<void> fetchBooks() async {
    entity = entity.copyWith(
      status: BrowseStatus.loading,
    );

    await request<MyBooksGatewayOutput, MyBooksSuccessInput>(
      MyBooksGatewayOutput(),
      onSuccess: (success) {
        return entity.copyWith(
          status: BrowseStatus.loaded,
          books: success.books,
        );
      },
      onFailure: (failure) {
        return entity.copyWith(status: BrowseStatus.error);
      },
    );
  }
}

class BrowseBooksUIOutputTransformer
    extends OutputTransformer<BrowseBooksEntity, BrowseBooksUIOutput> {
  @override
  BrowseBooksUIOutput transform(BrowseBooksEntity entity) {
    final books = entity.books.map(
      (bookIdentity) {
        final substrings = bookIdentity.url.split('/');
        return BookModel(bookIdentity.title, 'http:${bookIdentity.picture}', substrings.last);
      },
    ).toList();

    return BrowseBooksUIOutput(status: entity.status, books: books);
  }
}
