import 'package:clean_framework/clean_framework.dart';

class BookIdentity {
  final String url;
  final String title;
  final String picture;

  BookIdentity({
    required this.url,
    required this.title,
    required this.picture,
  });

  factory BookIdentity.fromJson(Map<String, dynamic> json) {
    final deserializer = Deserializer(json);

    final picture = deserializer.getMap('picture')['url'] as String;

    return BookIdentity(
      url: deserializer.getString('url'),
      title: deserializer.getString('title'),
      picture: picture,
    );
  }
}
