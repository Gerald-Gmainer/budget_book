import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryTypeButton extends StatelessWidget {
  final BookingModel model;
  final CategoryType categoryType;
  final Function(CategoryType categoryType) onPressed;

  const CategoryTypeButton({required this.model, required this.categoryType, required this.onPressed});

  _onPressed() {
    onPressed(categoryType);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressed,
      child: Container(
        padding: const EdgeInsets.only(bottom: 2.0),
        decoration: _buildDecoration(model.categoryType == categoryType, categoryType.color),
        child: Text(
          categoryType.name.toUpperCase(),
          style: TextStyle(color: categoryType.color, fontSize: 12),
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
}
