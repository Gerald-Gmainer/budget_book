import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class DatePanel extends StatefulWidget {
  final BudgetPeriodModel periodModel;
  static final DateTime now = DateTime.now();

  const DatePanel({required this.periodModel});

  @override
  State<DatePanel> createState() => _DatePanelState();
}

class _DatePanelState extends State<DatePanel> {
  BudgetPeriod _selectedPeriod = BudgetPeriod.month;

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildDate());
  }

  Widget _buildDate() {
    return Text(
      _determineText().toUpperCase(),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.accentColor,
        fontFamily: GoogleFonts.kaushanScript().fontFamily,
      ),
    );
  }

  String _determineText() {
    switch (widget.periodModel.period) {
      case BudgetPeriod.month:
        return _determineMonthText();

      default:
        return "TODO";
    }
  }

  String _determineMonthText() {
    if (widget.periodModel.dateTime?.year == DatePanel.now.year) {
      return DateTimeConverter.toMMMM(widget.periodModel.dateTime);
    }
    return DateTimeConverter.toMMMMYYYY(widget.periodModel.dateTime);
  }

  Widget _buildPeriodSelect() {
    return DropdownButton<BudgetPeriod>(
      value: _selectedPeriod,
      onChanged: (BudgetPeriod? newValue) {
        setState(() {
          _selectedPeriod = newValue!;
        });
      },
      items: const [
        DropdownMenuItem<BudgetPeriod>(
          value: BudgetPeriod.day,
          child: Text("Day"),
        ),
        DropdownMenuItem<BudgetPeriod>(
          value: BudgetPeriod.month,
          child: Text("Month"),
        ),
        DropdownMenuItem<BudgetPeriod>(
          value: BudgetPeriod.year,
          child: Text("Year"),
        ),
        DropdownMenuItem<BudgetPeriod>(
          value: BudgetPeriod.all,
          child: Text("All"),
        ),
      ],
    );
  }
}
