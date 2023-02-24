import 'package:bookish_invention/features/book_detail/domain/book_detail_entity.dart';
import 'package:bookish_invention/features/book_detail/external_interface/book_detail_gateway.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/foundation.dart';

class BookDetailViewModel extends ViewModel {
  const BookDetailViewModel({
    required this.status,
    required this.bookDetail,
    required this.onRefresh,
  });

  final BookDetailStatus status;
  final BookDetailModel? bookDetail;
  final AsyncCallback onRefresh;

  @override
  List<Object?> get props {
    return [status, bookDetail, onRefresh];
  }
}
