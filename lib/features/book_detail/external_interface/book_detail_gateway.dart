import 'package:bookish_invention/core/open_library/open_library_request.dart';
import 'package:bookish_invention/core/open_library/open_library_success_response.dart';
import 'package:clean_framework/clean_framework.dart';

class BookDetailGateway extends Gateway<BookDetailGatewayOutput, BookDetailRequest,
    OpenLibrarySuccessResponse, BookDetailSuccessInput> {
  @override
  BookDetailRequest buildRequest(BookDetailGatewayOutput output) {
    return BookDetailRequest(output.openLibraryBookId);
  }

  @override
  FailureInput onFailure(covariant FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  BookDetailSuccessInput onSuccess(covariant OpenLibrarySuccessResponse response) {
    final entry = response.data.entries.first.value as Map<String, dynamic>;

    final deserializer = Deserializer(entry);

    final authors = deserializer.getList('authors', converter: (map) {
      return map['name'] as String;
    });

    final publishDate = deserializer.getString('publish_date');

    final coverUrl = deserializer.getMap('cover')['medium'] as String;

    final subjects = deserializer.getList('subjects', converter: (map) {
      return map['name'] as String;
    });

    final model = BookDetailModel(
      author: authors.first,
      publishDate: publishDate,
      coverUrl: coverUrl,
      subjects: subjects,
    );

    return BookDetailSuccessInput(model);
  }
}

class BookDetailGatewayOutput extends Output {
  const BookDetailGatewayOutput(this.openLibraryBookId);

  final String openLibraryBookId;

  @override
  List<Object?> get props => [openLibraryBookId];
}

class BookDetailSuccessInput extends SuccessInput {
  final BookDetailModel bookDetail;

  const BookDetailSuccessInput(this.bookDetail);
}

class BookDetailRequest extends OpenLibraryGetRequest {
  BookDetailRequest(this.openLibraryBookId);

  final String openLibraryBookId;

  @override
  String get resource => '/api/books';

  @override
  Map<String, dynamic> get queryParams => {
        'bibkeys': 'OLID:$openLibraryBookId',
        'jscmd': 'data',
        'format': 'json',
      };
}

class BookDetailModel {
  final String author;
  final String publishDate;
  final String coverUrl;
  final List<String> subjects;

  BookDetailModel({
    required this.author,
    required this.publishDate,
    required this.coverUrl,
    required this.subjects,
  });
}
