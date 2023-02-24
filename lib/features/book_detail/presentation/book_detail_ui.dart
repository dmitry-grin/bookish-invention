import 'package:bookish_invention/features/book_detail/domain/book_detail_entity.dart';
import 'package:bookish_invention/features/book_detail/presentation/book_detail_presenter.dart';
import 'package:bookish_invention/features/book_detail/presentation/book_detail_view_model.dart';
import 'package:bookish_invention/widgets/default_error_widget.dart';
import 'package:bookish_invention/widgets/shimmer_animating_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _coverWidth = 150;
const double _coverHeight = 240;

class BookDetailUI extends UI<BookDetailViewModel> {
  BookDetailUI({
    required this.title,
    required this.bookId,
    super.key,
  });

  final String title;
  final String bookId;

  @override
  BookDetailPresenter create(WidgetBuilder builder) {
    return BookDetailPresenter(builder: builder, bookId: bookId);
  }

  @override
  Widget build(BuildContext context, BookDetailViewModel viewModel) {
    return Scaffold(
      appBar: CupertinoNavigationBar(middle: Text(title)),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: viewModel.onRefresh),
            buildBody(viewModel),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BookDetailViewModel viewModel) {
    if (viewModel.status == BookDetailStatus.loading) {
      return buildLoading();
    }

    if (viewModel.status == BookDetailStatus.error) {
      return DefaultErrorWidget(onRefresh: viewModel.onRefresh);
    }

    if (viewModel.bookDetail != null) {
      final bookDetail = viewModel.bookDetail!;

      return SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            Column(
              children: [
                const SizedBox(height: 32),
                CachedNetworkImage(
                  width: _coverWidth,
                  height: _coverHeight,
                  imageUrl: bookDetail.coverUrl,
                  placeholder: (_, __) {
                    return const RectanglePlaceholder(
                      width: _coverWidth,
                      height: _coverHeight,
                    );
                  },
                ),
                const SizedBox(height: 32),
                Text(
                  bookDetail.author,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  children: [
                    for (var i = 0; i < bookDetail.subjects.length && i < 16; i++) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(
                          backgroundColor: Colors.black,
                          label: Text(
                            bookDetail.subjects[i],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ],
                )
              ],
            ),
          ],
        ),
      );
    }

    return const SliverToBoxAdapter();
  }

  Widget buildLoading() {
    return SliverToBoxAdapter(
      child: ShimmerAnimatingContainer(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const RectanglePlaceholder(
              width: _coverWidth,
              height: _coverHeight,
            ),
            const SizedBox(height: 32),
            const RectanglePlaceholder(
              width: 240,
              height: 44,
            ),
            const SizedBox(height: 16),
            Wrap(
              children: List.generate(16, (index) {
                final double fakeWidth = index % 2 == 0
                    ? index % 3 == 0
                        ? 60
                        : 44
                    : 70;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Chip(
                    backgroundColor: Colors.white,
                    label: SizedBox(
                      width: fakeWidth,
                      height: 25,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
