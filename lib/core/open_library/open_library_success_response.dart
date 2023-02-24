import 'package:clean_framework/clean_framework.dart';

class OpenLibrarySuccessResponse extends SuccessResponse {
  const OpenLibrarySuccessResponse({required this.data});

  final Map<String, dynamic> data;
}
