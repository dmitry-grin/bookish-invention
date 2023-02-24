import 'package:bookish_invention/core/open_library/open_library_request.dart';
import 'package:bookish_invention/core/open_library/open_library_success_response.dart';
import 'package:bookish_invention/features/browse_books/external_interface/book_identity.dart';
import 'package:clean_framework/clean_framework.dart';

class MyBooksGateway extends Gateway<MyBooksGatewayOutput, GetMyBooksRequest,
    OpenLibrarySuccessResponse, MyBooksSuccessInput> {
  @override
  GetMyBooksRequest buildRequest(MyBooksGatewayOutput output) {
    return GetMyBooksRequest();
  }

  @override
  FailureInput onFailure(
    covariant FailureResponse failureResponse,
  ) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  MyBooksSuccessInput onSuccess(covariant OpenLibrarySuccessResponse response) {
    final deserializer = Deserializer(response.data);

    return MyBooksSuccessInput(
      deserializer.getList(
        'entries',
        converter: BookIdentity.fromJson,
      ),
    );
  }
}

class MyBooksGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class MyBooksSuccessInput extends SuccessInput {
  final List<BookIdentity> books;

  const MyBooksSuccessInput(this.books);
}

class GetMyBooksRequest extends OpenLibraryGetRequest {
  @override
  String get resource => '/people/deemilees/lists/OL222637L/seeds.json';

  @override
  Map<String, dynamic> get queryParams => {};
}
