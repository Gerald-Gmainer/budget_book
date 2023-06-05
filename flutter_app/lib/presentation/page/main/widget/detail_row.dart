import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailRow extends StatelessWidget {
  final BudgetPeriodModel periodModel;

  const DetailRow({super.key, required this.periodModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: periodModel.bookings.map((e) => _buildRow(context, e)).toList(),
    );
  }

  Widget _buildRow(BuildContext context, BookingModel bookingModel) {
    NumberFormat yenFormat = NumberFormat.currency(decimalDigits: 0, symbol: "");
    String formattedAmount = yenFormat.format(bookingModel.amount);
    return Text("${DateTimeConverter.toDateString(bookingModel.bookingDate)} / $formattedAmount");
  }
}
