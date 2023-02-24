import 'package:bookish_invention/features/book_detail/domain/book_detail_ui_output.dart';
import 'package:bookish_invention/features/book_detail/domain/book_detail_usecase.dart';
import 'package:bookish_invention/features/book_detail/presentation/book_detail_view_model.dart';
import 'package:bookish_invention/providers.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';

class BookDetailPresenter
    extends Presenter<BookDetailViewModel, BookDetailUIOutput, BookDetailUseCase> {
  BookDetailPresenter({
    super.key,
    required super.builder,
    required this.bookId,
  }) : super(provider: bookDetailProvider);

  final String bookId;

  @override
  void onLayoutReady(BuildContext context, BookDetailUseCase useCase) {
    useCase.fetchBookDetail(bookId);
  }

  @override
  BookDetailViewModel createViewModel(BookDetailUseCase useCase, BookDetailUIOutput output) {
    return BookDetailViewModel(
      status: output.status,
      bookDetail: output.bookDetailModel,
      onRefresh: () async => await useCase.fetchBookDetail(bookId),
    );
  }

  @override
  void onOutputUpdate(BuildContext context, BookDetailUIOutput output) {}
}
