import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryTypeButton extends StatelessWidget {
  final BookingCrudModel crudModel;
  final CategoryType categoryType;
  final Function(CategoryType categoryType) onPressed;

  const CategoryTypeButton({required this.crudModel, required this.categoryType, required this.onPressed});

  _onPressed() {
    onPressed(categoryType);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressed,
      child: Container(
        padding: const EdgeInsets.only(bottom: 4.0),
        decoration: _buildDecoration(crudModel.categoryType == categoryType, _getColor()),
        child: Text(
          categoryType.name.toUpperCase(),
          style: TextStyle(color: _getColor()),
        ),
      ),
    );
  }

  _buildDecoration(bool hasUnderline, Color color) {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: hasUnderline ? color : Colors.transparent,
          width: 2.0,
        ),
      ),
    );
  }

  _getColor() {
    return categoryType == CategoryType.income ? AppColors.incomeColor : AppColors.outcomeColor;
  }
}
