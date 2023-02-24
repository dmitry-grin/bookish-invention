import 'package:bookish_invention/features/browse_books/domain/browse_books_entity.dart';
import 'package:bookish_invention/features/browse_books/presentation/browse_books_presenter.dart';
import 'package:bookish_invention/features/browse_books/presentation/browse_books_view_model.dart';
import 'package:bookish_invention/widgets/book_tile.dart';
import 'package:bookish_invention/widgets/default_error_widget.dart';
import 'package:bookish_invention/widgets/shimmer_animating_container.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrowseBooksUI extends UI<BrowseBooksViewModel> {
  BrowseBooksUI({super.key});

  @override
  BrowseBooksPresenter create(WidgetBuilder builder) => BrowseBooksPresenter(builder: builder);

  @override
  Widget build(BuildContext context, BrowseBooksViewModel viewModel) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Books'),
          ),
          CupertinoSliverRefreshControl(onRefresh: viewModel.onRefresh),
          buildBody(viewModel),
        ],
      ),
    );
  }

  Widget buildBody(BrowseBooksViewModel viewModel) {
    if (viewModel.status == BrowseStatus.loading) {
      return buildLoading();
    }

    if (viewModel.status == BrowseStatus.error) {
      return DefaultErrorWidget(
        onRefresh: viewModel.onRefresh,
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return BookTile(
            book: viewModel.books[index],
          );
        },
        childCount: viewModel.books.length,
      ),
    );
  }

  Widget buildLoading() {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ShimmerAnimatingContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 32),
                        child: RectanglePlaceholder(
                          width: 44,
                          height: 60,
                        ),
                      ),
                      RectanglePlaceholder(
                        height: 24,
                        width: 120,
                      ),
                    ],
                  ),
                  const RectanglePlaceholder(
                    height: 24,
                    width: 24,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
