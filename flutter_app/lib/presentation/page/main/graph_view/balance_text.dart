import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class BalanceText extends StatelessWidget {
  final BudgetPeriodModel periodModel;

  const BalanceText({required this.periodModel});

  @override
  Widget build(BuildContext context) {
    return CurrencyText(
      value: periodModel.balance,
      style: TextStyle(
        color: periodModel.balance.isNegative ? AppColors.outcomeColor : AppColors.incomeColor,
        fontSize: 20,
      ),
    );
  }
}
