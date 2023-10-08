import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';

class DatePanel extends StatelessWidget {
  final BudgetPeriodModel periodModel;
  static final DateTime now = DateTime.now();

  const DatePanel({required this.periodModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _determineText(),
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _determineText() {
    switch (periodModel.period) {
      case BudgetPeriod.month:
        return _determineMonthText();

      default:
        return "TODO";
    }
  }

  String _determineMonthText() {
    if (periodModel.dateTime?.year == now.year) {
      return DateTimeConverter.toMMMM(periodModel.dateTime);
    }
    return DateTimeConverter.toMMMMYYYY(periodModel.dateTime);
  }
}
