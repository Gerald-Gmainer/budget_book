import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

import 'category_type_radio.dart';

class CategoryTypeRow extends StatelessWidget {
  final Function(CategoryType type) onTypeChange;
  final CategoryType selectedType;

  const CategoryTypeRow({required this.onTypeChange, required this.selectedType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Category Type', style: TextStyle(fontSize: 16)),
        Row(
          children: <Widget>[
            CategoryTypeRadio(
              text: "Outcome",
              onTypeChange: onTypeChange,
              selectedType: selectedType,
              value: CategoryType.outcome,
            ),
            const SizedBox(width: AppDimensions.horizontalPadding),
            CategoryTypeRadio(
              text: "Income",
              onTypeChange: onTypeChange,
              selectedType: selectedType,
              value: CategoryType.income,
            ),
          ],
        ),
      ],
    );
  }
}
