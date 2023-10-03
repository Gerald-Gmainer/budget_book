import 'package:flutter_app/data/data.dart';

class CategoryBookingGroupModel {
  final CategoryModel category;
  final List<BookingModel> bookings;
  final double amount;

  CategoryBookingGroupModel({required this.category, required this.bookings, required this.amount});

  @override
  String toString() {
    return [
      "category: $category",
      "bookings: $bookings",
    ].join(" / ");
  }
}
