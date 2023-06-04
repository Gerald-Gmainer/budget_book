import 'package:flutter_app/data/data.dart';

class BudgetPeriodModel {
  final BudgetPeriod period;
  final DateTime? dateTime;
  final DateTime? dateTimeFrom;
  final DateTime? dateTimeTo;
  final List<BookingModel> bookings;

  BudgetPeriodModel({
    required this.period,
    required this.dateTime,
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.bookings,
  });
}
