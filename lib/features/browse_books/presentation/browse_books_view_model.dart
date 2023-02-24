import 'package:bookish_invention/features/browse_books/domain/browse_books_entity.dart';
import 'package:bookish_invention/features/browse_books/models/book_model.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/foundation.dart';

class BrowseBooksViewModel extends ViewModel {
  const BrowseBooksViewModel({
    required this.status,
    required this.books,
    required this.onRefresh,
  });

  final BrowseStatus status;
  final List<BookModel> books;
  final AsyncCallback onRefresh;

  @override
  List<Object?> get props {
    return [status, books, onRefresh];
  }
}
