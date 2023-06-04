import 'package:flutter_app/data/data.dart';

class BudgetBookModel {
  final BudgetPeriod currentPeriod;
  final List<BudgetPeriodModel> periodModels;
  final int currentPeriodIndex;
  final List<AccountModel> accounts;

  BudgetBookModel({
    required this.currentPeriod,
    required this.periodModels,
    required this.currentPeriodIndex,
    required this.accounts,
  });
}
