import 'package:clean_framework/clean_framework.dart';

abstract class OpenLibraryRequest extends Request {
  Map<String, dynamic> get queryParams => {};
}

abstract class OpenLibraryGetRequest extends OpenLibraryRequest {
  String get resource;
}
