import 'package:flutter_app/business_logic/business_logic.dart';

class BookingListPageModel {
  final List<BookingModel>? bookings;
  final CategoryBookingGroupModel? categoryGroupModel;

  BookingListPageModel({
    this.bookings,
    this.categoryGroupModel,
  });
}
