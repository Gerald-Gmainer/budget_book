import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

import 'calculator/calculator.dart';
import 'widget/amount_display.dart';
import 'widget/choose_category_button.dart';
import 'widget/date_input.dart';
import 'widget/description_input.dart';

class BookingCrudTab1 extends StatelessWidget {
  final BookingModel model;
  final VoidCallback onCategoryTap;

  const BookingCrudTab1({required this.model, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      double appBarHeight = AppBar().preferredSize.height;
      double screenHeight = MediaQuery.of(context).size.height - appBarHeight;
      final hideQuickButtons = screenHeight < 600;

      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DateInput(model: model, hideQuickButtons: hideQuickButtons),
          const SizedBox(height: AppDimensions.verticalPadding * 2),
          AmountDisplay(),
          const SizedBox(height: AppDimensions.verticalPadding),
          DescriptionInput(model: model),
          const Spacer(),
          Calculator(model: model),
          const SizedBox(height: AppDimensions.verticalPadding * 2),
          SaveButton(text: "choose category", onTap: onCategoryTap),
          const SizedBox(height: AppDimensions.verticalPadding),
        ],
      );
    });
  }
}
