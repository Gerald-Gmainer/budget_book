import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/app_dimensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailRow extends StatelessWidget {
  final BudgetPeriodModel periodModel;
  final List<CategoryModel> categories;

  const DetailRow({super.key, required this.periodModel, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...periodModel.categoryBookingGroupModels.map((e) => _buildCategory(context, e)).toList()],
    );
  }

  Widget _buildCategory(BuildContext context, CategoryBookingGroupModel groupModel) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.verticalPadding),
        Text(groupModel.category.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...groupModel.bookings.map((e) => _buildBooking(context, e)).toList(),
        const SizedBox(height: AppDimensions.verticalPadding),
      ],
    );
  }

  Widget _buildBooking(BuildContext context, BookingModel bookingModel) {
    NumberFormat yenFormat = NumberFormat.currency(decimalDigits: 0, symbol: "");
    String formattedAmount = yenFormat.format(bookingModel.amount);
    return Text("${DateTimeConverter.toDateString(bookingModel.bookingDate)} / $formattedAmount");
  }
}
