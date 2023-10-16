import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class BookingOverview extends StatelessWidget {
  static const double fontSize = 14;
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
            title: _buildTitle(item.category, _calculatePercentage(item)),
            trailing: _buildTrailing(item.category, item.amount),
            onTap: () {
              _onTap(context, item);
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTitle(CategoryModel category, int percent) {
    return Row(
      children: [
        Icon(IconConverter.getIconFromModel(category.iconData), color: ColorConverter.iconColorToColor(category.iconColor)),
        SizedBox(width: AppDimensions.horizontalPadding / 2),
        Expanded(child: Text(category.name ?? "", style: TextStyle(fontSize: fontSize), overflow: TextOverflow.ellipsis)),
        Text("$percent%", style: TextStyle(color: AppColors.secondaryTextColor, fontSize: fontSize)),
      ],
    );
  }

  int _calculatePercentage(CategoryBookingGroupModel item) {
    double total = item.category.categoryType == CategoryType.income ? periodModel.income : periodModel.outcome;
    return (item.amount / total * 100).round();
  }

  Widget _buildTrailing(CategoryModel category, double amount) {
    return SizedBox(
      width: 75,
      child: Align(
        alignment: Alignment.centerRight,
        child: CurrencyText(
          value: amount,
          style: TextStyle(color: category.categoryType.color, fontSize: fontSize),
        ),
      ),
    );
  }
}
