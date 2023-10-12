import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/enum/enum.dart';

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
