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
    return BookDetailSuccessInput(BookDetailModel.fromJson(response.data));
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

  factory BookDetailModel.fromJson(Map<String, dynamic> json) {
    final entry = json.entries.first.value as Map<String, dynamic>;

    final deserializer = Deserializer(entry);

    return BookDetailModel(
      author: deserializer.getList('authors', converter: (map) {
        return map['name'] as String;
      }).first,
      publishDate: deserializer.getString('publish_date'),
      coverUrl: deserializer.getMap('cover')['medium'] as String,
      subjects: deserializer.getList('subjects', converter: (map) {
        return map['name'] as String;
      }),
    );
  }
}
