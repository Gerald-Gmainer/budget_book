import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:intl/intl.dart';

class DateRow extends StatelessWidget {
  final BudgetPeriodModel periodModel;

  const DateRow({super.key, required this.periodModel});

  @override
  Widget build(BuildContext context) {
    return Text(_determineText(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }

  String _determineText() {
    switch (periodModel.period) {
      case BudgetPeriod.month:
        return DateFormat('MMMM').format(periodModel.dateTime!);

      default:
        return "TODO";
    }
  }
}
