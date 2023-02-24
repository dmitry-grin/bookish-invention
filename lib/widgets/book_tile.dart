import 'package:bookish_invention/features/browse_books/models/book_model.dart';
import 'package:bookish_invention/routing/routes.dart';
import 'package:bookish_invention/widgets/shimmer_animating_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _coverWidth = 44;
const double _coverHeight = 60;
const double _pressOpacity = 0.65;

class BookTile extends StatelessWidget {
  final BookModel book;

  const BookTile({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        context.router.go(
          Routes.bookDetail,
          queryParams: {
            'title': book.title,
            'bookId': book.bookId,
          },
        );
      },
      pressedOpacity: _pressOpacity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CachedNetworkImage(
                  width: _coverWidth,
                  height: _coverHeight,
                  imageUrl: book.imageUrl,
                  placeholder: (_, __) {
                    return const RectanglePlaceholder(
                      width: _coverWidth,
                      height: _coverHeight,
                    );
                  },
                ),
              ),
              Text(
                book.title,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
