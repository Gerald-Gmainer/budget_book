import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/presentation.dart';

class BookingListDate extends StatelessWidget {
  final DateTime date;

  const BookingListDate({required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      DateTimeConverter.toEEEEdMMMMYYY(date),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    );
  }
}
