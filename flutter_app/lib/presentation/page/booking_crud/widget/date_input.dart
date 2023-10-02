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
    widget.model.bookingModel.bookingDate ??= DateTime.now();
    _selectedDate = widget.model.bookingModel.bookingDate!;
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
      widget.model.bookingModel.bookingDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _onPressed(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.edit_calendar, color: AppColors.primaryTextColor),
          const SizedBox(width: 8),
          Text(
            DateTimeConverter.toEEEEdMMMM(_selectedDate),
            style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
