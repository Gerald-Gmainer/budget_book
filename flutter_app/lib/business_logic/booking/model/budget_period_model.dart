import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/enum/enum.dart';

class BudgetPeriodModel {
  final BudgetPeriodFilter periodFilter;
  final double income;
  final double outcome;
  final double balance;
  final List<CategoryBookingGroupModel> categoryBookingGroupModels;

  BudgetPeriodModel({
    required this.periodFilter,
    required this.income,
    required this.outcome,
    required this.balance,
    required this.categoryBookingGroupModels,
  });
}
