import 'package:flutter_app/data/data.dart';

class BudgetPeriodModel {
  final BudgetPeriod period;
  final DateTime? dateTime;
  final DateTime? dateTimeFrom;
  final DateTime? dateTimeTo;
  final double balance;
  final List<CategoryBookingGroupModel> categoryBookingGroupModels;

  BudgetPeriodModel({
    required this.period,
    required this.dateTime,
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.balance,
    required this.categoryBookingGroupModels,
  });
}
