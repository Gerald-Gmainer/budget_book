import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:intl/intl.dart';

class DateRow extends StatelessWidget {
  final BudgetPeriodModel periodModel;
  static final DateTime now = DateTime.now();

  const DateRow({required this.periodModel});

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
      return DateFormat('MMMM').format(periodModel.dateTime!);
    }
    return DateFormat('MMMM yyyy').format(periodModel.dateTime!);
  }
}
