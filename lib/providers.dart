import 'package:bookish_invention/core/open_library/open_library_external_interface.dart';
import 'package:bookish_invention/features/book_detail/domain/book_detail_entity.dart';
import 'package:bookish_invention/features/book_detail/domain/book_detail_usecase.dart';
import 'package:bookish_invention/features/book_detail/external_interface/book_detail_gateway.dart';
import 'package:bookish_invention/features/browse_books/domain/browse_books_use_case.dart';
import 'package:bookish_invention/features/browse_books/external_interface/my_books_gateway.dart';
import 'package:clean_framework/clean_framework.dart';

final browseBookProvider = UseCaseProvider.autoDispose(
  BrowseBooksUseCase.new,
);

final bookDetailProvider = UseCaseProvider<BookDetailEntity, BookDetailUseCase>(
  BookDetailUseCase.new,
);

final myBooksGatewayProvider = GatewayProvider(
  MyBooksGateway.new,
  useCases: [browseBookProvider],
);

final bookDetailGatewayProvider = GatewayProvider(
  BookDetailGateway.new,
  useCases: [bookDetailProvider],
);

final bookishExternalInterfaceProvider = ExternalInterfaceProvider(
  OpenLibraryExternalInterface.new,
  gateways: [myBooksGatewayProvider, bookDetailGatewayProvider],
);
