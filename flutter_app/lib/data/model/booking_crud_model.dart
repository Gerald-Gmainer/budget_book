import 'package:flutter_app/data/data.dart';

class BookingCrudModel {
  final BookingModel bookingModel;
  final CategoryType categoryType;

  BookingCrudModel({required this.bookingModel, required this.categoryType});

  @override
  String toString() {
    return "categoryType: $categoryType / model: $bookingModel";
  }
}
