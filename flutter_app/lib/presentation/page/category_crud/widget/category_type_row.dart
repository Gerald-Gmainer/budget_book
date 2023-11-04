import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enum/enum.dart';
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
        Text("category.type_label".tr(), style: TextStyle(fontSize: 16)),
        Row(
          children: <Widget>[
            CategoryTypeRadio(
              text: CategoryType.outcome.text.tr(),
              onTypeChange: onTypeChange,
              selectedType: selectedType,
              value: CategoryType.outcome,
            ),
            const SizedBox(width: AppDimensions.horizontalPadding),
            CategoryTypeRadio(
              text: CategoryType.income.text.tr(),
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
