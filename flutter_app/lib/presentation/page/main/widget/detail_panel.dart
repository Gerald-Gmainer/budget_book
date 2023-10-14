import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class DetailPanel extends StatelessWidget {
  final BudgetPeriodModel periodModel;
  final List<CategoryModel> categories;

  const DetailPanel({required this.periodModel, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: periodModel.categoryBookingGroupModels.length,
        itemBuilder: (context, index) {
          final item = periodModel.categoryBookingGroupModels[index];
          return Card(
            child: ListTile(
              title: _buildHeader(item.category),
              trailing: _buildTrailing(item.category, item.amount),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(CategoryModel category) {
    return Row(
      children: [
        Icon(IconConverter.getIconData(category.iconData?.name), color: ColorConverter.iconColorToColor(category.iconColor)),
        SizedBox(width: AppDimensions.horizontalPadding / 2),
        Text(category.name ?? ""),
      ],
    );
  }

  Widget _buildTrailing(CategoryModel category, double amount) {
    final color = category.categoryType == CategoryType.income ? AppColors.incomeColor : AppColors.outcomeColor;
    return CurrencyText(value: amount, style: TextStyle(color: color));
  }

  Widget _buildBody(List<BookingModel> bookings) {
    return Column(
      children: bookings.map((booking) {
        return ListTile(
          title: CurrencyText(value: booking.dataModel.amount),
          trailing: Text(DateTimeConverter.toMMMMdd(booking.dataModel.bookingDate)),
        );
      }).toList(),
    );
  }
}
