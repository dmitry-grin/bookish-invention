import 'package:bookish_invention/features/browse_books/external_interface/book_identity.dart';

class BookModel {
  final String title;
  final String imageUrl;
  final String bookId;

  BookModel({
    required this.title,
    required this.imageUrl,
    required this.bookId,
  });

  factory BookModel.fromBookIdentity(BookIdentity identity) {
    final substrings = identity.url.split('/');

    return BookModel(
      title: identity.title,
      imageUrl: 'http:${identity.picture}',
      bookId: substrings.last,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          imageUrl == other.imageUrl &&
          bookId == other.bookId;

  @override
  int get hashCode => title.hashCode ^ imageUrl.hashCode ^ bookId.hashCode;
}
