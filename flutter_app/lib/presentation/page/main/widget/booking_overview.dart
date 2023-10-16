import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class BookingOverview extends StatelessWidget {
  final BudgetPeriodModel periodModel;
  final List<CategoryModel> categories;

  const BookingOverview({required this.periodModel, required this.categories});

  _onTap(BuildContext context, CategoryBookingGroupModel item) {
    final model = BookingListPageModel(
      categoryGroupModel: item,
    );
    Navigator.of(context).pushNamed(BookingListPage.route, arguments: model);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: periodModel.categoryBookingGroupModels.map((item) {
        return Card(
          child: ListTile(
            title: _buildHeader(item.category),
            trailing: _buildTrailing(item.category, item.amount),
            onTap: () {
              _onTap(context, item);
            },
          ),
        );
      }).toList(),
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
    return CurrencyText(value: amount, style: TextStyle(color: category.categoryType.color));
  }
}
