import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class DatePanel extends StatelessWidget {
  final BudgetPeriodModel periodModel;
  static final DateTime now = DateTime.now();

  const DatePanel({required this.periodModel});

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
    switch (periodModel.periodFilter.period) {
      case BudgetPeriod.month:
        return _determineMonthText();

      default:
        return "TODO";
    }
  }

  String _determineMonthText() {
    if (periodModel.periodFilter.dateTime?.year == now.year) {
      return DateTimeConverter.toMMMM(periodModel.periodFilter.dateTime);
    }
    return DateTimeConverter.toMMMMYYYY(periodModel.periodFilter.dateTime);
  }
}
