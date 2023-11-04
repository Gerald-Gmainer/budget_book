import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class DateInput extends StatefulWidget {
  final BookingModel model;
  final bool hideQuickButtons;

  const DateInput({required this.model, required this.hideQuickButtons});

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  late DateTime _selectedDate;
  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.model.bookingDate ??= DateTime.now();
    _selectedDate = widget.model.bookingDate!;
  }

  _onDatePicker(BuildContext context) async {
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
      widget.model.bookingDate = picked;
    }
  }

  _onQuickPressed(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    widget.model.bookingDate = date;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDatePicker(),
        if (!widget.hideQuickButtons) _buildQuickButtons(),
      ],
    );
  }

  _buildDatePicker() {
    return TextButton(
      onPressed: () {
        _onDatePicker(context);
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

  _buildQuickButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildQuickButton(0, "booking.today"),
        const SizedBox(width: 8),
        _buildQuickButton(-1, "booking.yesterday"),
        const SizedBox(width: 8),
        _buildQuickButton(-2, "booking.before_yesterday"),
      ],
    );
  }

  _buildQuickButton(int dayDiff, String subtext) {
    final date = now.add(Duration(days: dayDiff));

    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          _onQuickPressed(date);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateTimeConverter.toMMdd(date),
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              subtext,
              style: const TextStyle(color: AppColors.secondaryTextColor),
            ).tr(),
          ],
        ),
      ),
    );
  }
}
