import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class DetailPanel extends StatelessWidget {
  final BudgetPeriodModel periodModel;
  final List<CategoryDataModel> categories;

  const DetailPanel({required this.periodModel, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CollapseableList(
        items: periodModel.categoryBookingGroupModels
            .map((e) => CollapseableItem(
                  header: _buildHeader(e.category),
                  trailing: _buildTrailing(e.category, e.amount),
                  body: _buildBody(e.bookings),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildHeader(CategoryModel category) {
    return Text(category.dataModel.name ?? "");
  }

  Widget _buildTrailing(CategoryModel category, double amount) {
    final color = category.categoryType == CategoryType.income ? AppColors.incomeColor : AppColors.outcomeColor;
    return Text(CurrencyConverter.format(amount), style: TextStyle(color: color));
  }

  Widget _buildBody(List<BookingModel> bookings) {
    return Column(
      children: bookings.map((booking) {
        return ListTile(
          title: Text(CurrencyConverter.format(booking.dataModel.amount)),
          trailing: Text(DateTimeConverter.toMMMMdd(booking.dataModel.bookingDate)),
        );
      }).toList(),
    );
  }
}
