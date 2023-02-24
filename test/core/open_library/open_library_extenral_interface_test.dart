import 'package:bookish_invention/core/open_library/open_library_external_interface.dart';
import 'package:bookish_invention/core/open_library/open_library_request.dart';
import 'package:clean_framework/clean_framework.dart' as clean;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() async {
  group('OpenLibraryExternalInterface tests', () {
    test('get request success', () async {
      final dio = DioMock();

      when(
        () => dio.get<Map<String, dynamic>>(
          'book',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {'title': 'Pragmatic Programmer'},
          requestOptions: RequestOptions(path: 'book'),
        ),
      );

      final interface = OpenLibraryExternalInterface(dio: dio);

      final result = await interface.request(TestOpenLibraryRequest());

      expect(result.isRight, isTrue);
      expect(result.right.data, equals({'title': 'Pragmatic Programmer'}));
    });

    test('get request failure', () async {
      final dio = DioMock();

      final error = DioError.connectionError(
        requestOptions: RequestOptions(),
        reason: 'No Internet',
      );

      when(
        () => dio.get<Map<String, dynamic>>(
          'book',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(error);

      final interface = OpenLibraryExternalInterface(dio: dio);

      final result = await interface.request(TestOpenLibraryRequest());

      expect(result.isLeft, isTrue);
      expect(result.left, isA<clean.FailureResponse>());
      expect(result.left.message, error.toString());
    });
  });
}

class TestOpenLibraryRequest extends OpenLibraryGetRequest {
  @override
  String get resource => 'book';
}

class DioMock extends Mock implements Dio {}
