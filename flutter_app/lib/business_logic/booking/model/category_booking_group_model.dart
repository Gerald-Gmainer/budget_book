import 'package:flutter_app/business_logic/business_logic.dart';

class CategoryBookingGroupModel {
  final CategoryModel category;
  final List<BookingModel> bookings;
  final double amount;

  CategoryBookingGroupModel({required this.category, required this.bookings, required this.amount});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is CategoryBookingGroupModel) {
      return category.id == other.category.id;
    }
    return false;
  }

  @override
  int get hashCode {
    return category.id.hashCode;
  }

  @override
  String toString() {
    return [
      "category: $category",
      "bookings: $bookings",
    ].join(" / ");
  }
}
