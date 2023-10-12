import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/enum/enum.dart';

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
