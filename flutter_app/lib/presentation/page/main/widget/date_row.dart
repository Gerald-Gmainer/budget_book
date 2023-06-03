import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRow extends StatelessWidget {
  final DateTime currentMonth;

  const DateRow({super.key, required this.currentMonth});

  @override
  Widget build(BuildContext context) {
    return Text(DateFormat('MMMM').format(currentMonth), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }
}
