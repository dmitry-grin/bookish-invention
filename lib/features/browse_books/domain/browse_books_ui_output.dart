import 'package:bookish_invention/features/browse_books/domain/browse_books_entity.dart';
import 'package:bookish_invention/features/browse_books/models/book_model.dart';
import 'package:clean_framework/clean_framework.dart';

class BrowseBooksUIOutput extends Output {
  const BrowseBooksUIOutput({required this.status, required this.books});

  final BrowseStatus status;
  final List<BookModel> books;

  @override
  List<Object?> get props => [status, books];
}
