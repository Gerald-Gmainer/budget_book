import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class TotalText extends StatelessWidget {
  final BudgetPeriodModel periodModel;
  final CategoryType categoryType;

  const TotalText({required this.periodModel, required this.categoryType});

  @override
  Widget build(BuildContext context) {
    return CurrencyText(
      value: categoryType == CategoryType.outcome ? periodModel.outcome : periodModel.income,
      style: TextStyle(
        color: categoryType.color,
        fontSize: 18,
      ),
    );
  }
}
