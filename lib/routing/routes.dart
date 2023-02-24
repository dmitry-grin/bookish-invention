import 'package:bookish_invention/features/book_detail/presentation/book_detail_ui.dart';
import 'package:bookish_invention/features/browse_books/presentation/browse_books_ui.dart';
import 'package:clean_framework_router/clean_framework_router.dart';

enum Routes with RoutesMixin {
  browseBooks('/'),
  bookDetail('book_detail');

  const Routes(this.path);

  @override
  final String path;
}

class BookishRouter extends AppRouter<Routes> {
  @override
  RouterConfiguration configureRouter() {
    return RouterConfiguration(
      routes: [
        AppRoute(
          route: Routes.browseBooks,
          builder: (_, __) => BrowseBooksUI(),
          routes: [
            AppRoute(
              route: Routes.bookDetail,
              builder: (_, state) {
                return BookDetailUI(
                  title: state.queryParams['title'] ?? '',
                  bookId: state.queryParams['bookId'] ?? '',
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
