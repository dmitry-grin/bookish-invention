import 'package:bookish_invention/features/book_detail/external_interface/book_detail_gateway.dart';
import 'package:clean_framework/clean_framework.dart';

enum BookDetailStatus { initial, loading, loaded, error }

class BookDetailEntity extends Entity {
  const BookDetailEntity({
    this.status = BookDetailStatus.initial,
    this.bookDetail,
  });

  final BookDetailModel? bookDetail;
  final BookDetailStatus status;

  @override
  BookDetailEntity copyWith({
    BookDetailStatus? status,
    BookDetailModel? bookDetail,
  }) {
    return BookDetailEntity(
      bookDetail: bookDetail ?? this.bookDetail,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, bookDetail];
}
