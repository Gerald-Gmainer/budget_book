import 'package:flutter_app/data/data.dart';

class CategoryBookingGroupModel {
  final CategoryModel category;
  final List<BookingModel> bookings;

  CategoryBookingGroupModel({required this.category, required this.bookings});

  //
  // CategoryBookingGroupModel(this.category, BookingModel booking) {
  //   addBooking(booking);
  // }
  //
  // addBooking(BookingModel booking) {
  //   bookings.add(booking);
  // }

  @override
  String toString() {
    return [
      "category: $category",
      "bookings: $bookings",
    ].join(" / ");
  }
}
