import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

import 'calculator/calculator.dart';
import 'widget/amount_display.dart';
import 'widget/choose_category_button.dart';
import 'widget/date_input.dart';
import 'widget/date_quick_buttons.dart';
import 'widget/description_input.dart';

class BookingCrudTab1 extends StatelessWidget {
  final BookingCrudModel crudModel;
  final VoidCallback onCategoryTap;

  const BookingCrudTab1({required this.crudModel, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateInput(model: crudModel),
        DateQuickButtons(crudModel: crudModel),
        const SizedBox(height: AppDimensions.verticalPadding),
        AmountDisplay(),
        DescriptionInput(model: crudModel),
        const Spacer(),
        Calculator(model: crudModel),
        ChooseCategoryButton(model: crudModel, onPressed: onCategoryTap),
      ],
    );
  }
}
