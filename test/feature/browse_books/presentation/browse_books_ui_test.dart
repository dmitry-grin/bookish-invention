import 'package:bookish_invention/features/browse_books/domain/browse_books_entity.dart';
import 'package:bookish_invention/features/browse_books/models/book_model.dart';
import 'package:bookish_invention/features/browse_books/presentation/browse_books_ui.dart';
import 'package:bookish_invention/features/browse_books/presentation/browse_books_view_model.dart';
import 'package:bookish_invention/widgets/default_error_widget.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  group('BrowseBooksUI tests', () {
    uiTest(
      'shows books list',
      ui: BrowseBooksUI(),
      viewModel: BrowseBooksViewModel(
        books: [
          BookModel(
            title: '1984',
            imageUrl: 'http://covers.openlibrary.org/b/id/8579190-S.jpg',
            bookId: 'OL24199103M',
          ),
          BookModel(
            title: 'Fight club',
            imageUrl: 'http://covers.openlibrary.org/b/id/8579190-S.jpg',
            bookId: 'OL24199103M',
          ),
        ],
        onRefresh: () async {},
        status: BrowseStatus.loaded,
      ),
      verify: (tester) async {
        expect(find.text('1984'), findsOneWidget);
        expect(find.text('Fight club'), findsOneWidget);
      },
    );

    uiTest(
      'shows $DefaultErrorWidget on error',
      ui: BrowseBooksUI(),
      viewModel: BrowseBooksViewModel(
        books: const [],
        onRefresh: () async {},
        status: BrowseStatus.error,
      ),
      verify: (tester) async {
        expect(find.byType(DefaultErrorWidget), findsOneWidget);
      },
    );

    uiTest(
      'shows shimmer if loading data',
      ui: BrowseBooksUI(),
      viewModel: BrowseBooksViewModel(
        books: const [],
        onRefresh: () async {},
        status: BrowseStatus.loading,
      ),
      verify: (tester) async {
        expect(find.byType(Shimmer), findsWidgets);
      },
    );
  });
}
