import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

import 'calculator/calculator.dart';
import 'widget/amount_display.dart';
import 'widget/choose_category_button.dart';
import 'widget/date_input.dart';
import 'widget/description_input.dart';

class BookingCrudTab1 extends StatelessWidget {
  final BookingCrudModel crudModel;
  final VoidCallback onCategoryTap;

  const BookingCrudTab1({required this.crudModel, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      double appBarHeight = AppBar().preferredSize.height;
      double screenHeight = MediaQuery.of(context).size.height - appBarHeight;
      final hideQuickButtons = screenHeight < 600;

      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DateInput(model: crudModel, hideQuickButtons: hideQuickButtons),
          const SizedBox(height: AppDimensions.verticalPadding * 2),
          AmountDisplay(),
          const SizedBox(height: AppDimensions.verticalPadding),
          DescriptionInput(model: crudModel),
          const Spacer(),
          Calculator(model: crudModel),
          const SizedBox(height: AppDimensions.verticalPadding),
          ChooseCategoryButton(model: crudModel, onPressed: onCategoryTap),
          const SizedBox(height: AppDimensions.verticalPadding),
        ],
      );
    });
  }
}
