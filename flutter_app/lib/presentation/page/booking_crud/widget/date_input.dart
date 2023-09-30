import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class DateInput extends StatefulWidget {
  final BookingCrudModel model;

  const DateInput({required this.model});

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    widget.model.model.bookingDate ??= DateTime.now();
    _selectedDate = widget.model.model.bookingDate!;
  }

  _onPressed(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.model.model.bookingDate = picked;
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
