import 'package:bookish_invention/features/browse_books/external_interface/book_identity.dart';
import 'package:clean_framework/clean_framework.dart';

enum BrowseStatus { initial, loading, loaded, error }

class BrowseBooksEntity extends Entity {
  const BrowseBooksEntity({
    this.status = BrowseStatus.initial,
    this.books = const [],
  });

  final List<BookIdentity> books;
  final BrowseStatus status;

  @override
  BrowseBooksEntity copyWith({
    BrowseStatus? status,
    List<BookIdentity>? books,
  }) {
    return BrowseBooksEntity(
      books: books ?? this.books,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, books];
}
