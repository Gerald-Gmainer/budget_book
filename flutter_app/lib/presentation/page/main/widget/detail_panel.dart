import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class DetailPanel extends StatelessWidget {
  final BudgetPeriodModel periodModel;
  final List<CategoryModel> categories;

  const DetailPanel({required this.periodModel, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CollapseableList(
        items: periodModel.categoryBookingGroupModels
            .map((e) => CollapseableItem(
                  header: _buildHeader(e.category),
                  trailing: _buildTrailing(e.category, e.bookings),
                  body: _buildBody(e.bookings),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildHeader(CategoryModel category) {
    return Text(category.name);
  }

  Widget _buildTrailing(CategoryModel category, List<BookingModel> bookings) {
    final total = _calculateCategoryBalance(bookings);
    final color = category.categoryType == CategoryType.income ? AppColors.incomeColor : AppColors.outcomeColor;
    return Text(CurrencyConverter.format(total), style: TextStyle(color: color));
  }

  Widget _buildBody(List<BookingModel> bookings) {
    return Column(
      children: bookings.map((booking) {
        return ListTile(
          title: Text(CurrencyConverter.format(booking.amount)),
          trailing: Text(DateTimeConverter.toMMMMdd(booking.bookingDate)),
        );
      }).toList(),
    );
  }

  double _calculateCategoryBalance(List<BookingModel> bookings) {
    double totalAmount = 0;
    for (var booking in bookings) {
      totalAmount += booking.amount ?? 0;
    }
    return totalAmount;
  }
}
