import 'package:flutter_app/data/data.dart';

class BudgetBookModel {
  final BudgetPeriod currentPeriod;
  final List<BudgetPeriodModel> periodModels;
  final List<AccountModel> accounts;
  final List<CategoryModel> categories;

  BudgetBookModel({
    required this.currentPeriod,
    required this.periodModels,
    required this.accounts,
    required this.categories,
  });
}
