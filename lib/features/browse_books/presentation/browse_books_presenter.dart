import 'package:bookish_invention/features/browse_books/domain/browse_books_ui_output.dart';
import 'package:bookish_invention/features/browse_books/domain/browse_books_use_case.dart';
import 'package:bookish_invention/features/browse_books/presentation/browse_books_view_model.dart';
import 'package:bookish_invention/providers.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

class BrowseBooksPresenter
    extends Presenter<BrowseBooksViewModel, BrowseBooksUIOutput, BrowseBooksUseCase> {
  BrowseBooksPresenter({super.key, required super.builder}) : super(provider: browseBookProvider);

  @override
  void onLayoutReady(BuildContext context, BrowseBooksUseCase useCase) {
    useCase.fetchBooks();
  }

  @override
  BrowseBooksViewModel createViewModel(BrowseBooksUseCase useCase, BrowseBooksUIOutput output) {
    return BrowseBooksViewModel(
      status: output.status,
      books: output.books,
      onRefresh: () => useCase.fetchBooks(),
    );
  }

  @override
  void onOutputUpdate(BuildContext context, BrowseBooksUIOutput output) {}
}
