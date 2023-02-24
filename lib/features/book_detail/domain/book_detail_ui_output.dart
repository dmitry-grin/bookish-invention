import 'package:bookish_invention/features/book_detail/domain/book_detail_entity.dart';
import 'package:bookish_invention/features/book_detail/external_interface/book_detail_gateway.dart';
import 'package:clean_framework/clean_framework.dart';

class BookDetailUIOutput extends Output {
  const BookDetailUIOutput({required this.status, this.bookDetailModel});

  final BookDetailStatus status;
  final BookDetailModel? bookDetailModel;

  @override
  List<Object?> get props => [status, bookDetailModel];
}
