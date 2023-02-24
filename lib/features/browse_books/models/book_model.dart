class BookModel {
  final String title;
  final String imageUrl;
  final String bookId;

  BookModel(this.title, this.imageUrl, this.bookId);

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
