import 'package:bookish_invention/core/open_library/open_library_request.dart';
import 'package:bookish_invention/core/open_library/open_library_success_response.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:dio/dio.dart';

class OpenLibraryExternalInterface
    extends ExternalInterface<OpenLibraryRequest, OpenLibrarySuccessResponse> {
  OpenLibraryExternalInterface({
    Dio? dio,
  }) : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://openlibrary.org'));

  final Dio _dio;

  @override
  void handleRequest() {
    on<OpenLibraryGetRequest>(
      (request, send) async {
        final response = await _dio.get<Map<String, dynamic>>(
          request.resource,
          queryParameters: request.queryParams,
        );

        final data = response.data!;

        send(OpenLibrarySuccessResponse(data: data));
      },
    );
  }

  @override
  FailureResponse onError(Object error) {
    return UnknownFailureResponse(error);
  }
}
