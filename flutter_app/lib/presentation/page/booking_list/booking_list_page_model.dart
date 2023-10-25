import 'package:flutter_app/business_logic/business_logic.dart';

class BookingListPageModel {
  final CategoryBookingGroupModel categoryGroupModel;
  final BudgetPeriodFilter periodFilter;

  BookingListPageModel({
    required this.periodFilter,
    required this.categoryGroupModel,
  });
}
