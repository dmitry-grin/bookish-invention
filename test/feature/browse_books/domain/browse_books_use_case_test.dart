import 'package:bookish_invention/features/browse_books/domain/browse_books_entity.dart';
import 'package:bookish_invention/features/browse_books/domain/browse_books_ui_output.dart';
import 'package:bookish_invention/features/browse_books/domain/browse_books_use_case.dart';
import 'package:bookish_invention/features/browse_books/external_interface/book_identity.dart';
import 'package:bookish_invention/features/browse_books/external_interface/my_books_gateway.dart';
import 'package:bookish_invention/features/browse_books/models/book_model.dart';
import 'package:bookish_invention/providers.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'BrowseBooksUsecase test',
    () {
      final bookModel = [
        BookModel(
          title: '1984',
          imageUrl: 'http://covers.openlibrary.org/b/id/8579190-S.jpg',
          bookId: 'OL24199103M',
        )
      ];

      useCaseTest<BrowseBooksUseCase, BrowseBooksEntity, BrowseBooksUIOutput>(
        'fetch books success',
        provider: browseBookProvider,
        execute: (usecase) {
          _mockSuccess(usecase);

          return usecase.fetchBooks();
        },
        expect: () => [
          const BrowseBooksUIOutput(
            status: BrowseStatus.loading,
            books: [],
          ),
          BrowseBooksUIOutput(
            status: BrowseStatus.loaded,
            books: bookModel,
          ),
        ],
        verify: (useCase) {
          expect(
            useCase.debugEntity,
            BrowseBooksEntity(status: BrowseStatus.loaded, books: bookModel),
          );
        },
      );

      useCaseTest<BrowseBooksUseCase, BrowseBooksEntity, BrowseBooksUIOutput>(
        'fetch books failure',
        provider: browseBookProvider,
        execute: (usecase) {
          _mockFailure(usecase);

          return usecase.fetchBooks();
        },
        expect: () => [
          const BrowseBooksUIOutput(
            status: BrowseStatus.loading,
            books: [],
          ),
          const BrowseBooksUIOutput(
            status: BrowseStatus.error,
            books: [],
          ),
        ],
      );
    },
  );
}

void _mockSuccess(BrowseBooksUseCase useCase) {
  useCase.subscribe<MyBooksGatewayOutput, MyBooksSuccessInput>(
    (_) async {
      return Either.right(
        MyBooksSuccessInput(
          [
            BookIdentity(
              url: '/books/OL24199103M',
              title: '1984',
              picture: '//covers.openlibrary.org/b/id/8579190-S.jpg',
            ),
          ],
        ),
      );
    },
  );
}

void _mockFailure(BrowseBooksUseCase useCase) {
  useCase.subscribe<MyBooksGatewayOutput, MyBooksSuccessInput>(
    (_) async {
      return const Either.left(
        FailureInput(message: 'Bad Network'),
      );
    },
  );
}
