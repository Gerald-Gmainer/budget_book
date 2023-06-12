import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class DateInput extends StatefulWidget {
  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  DateTime _selectedDate = DateTime.now();

  _onPressed(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _onPressed) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _onPressed(context);
      },
      child: Text(
        DateTimeConverter.toEEEEdMMMM(_selectedDate),
        style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
      ),
    );
  }
}
