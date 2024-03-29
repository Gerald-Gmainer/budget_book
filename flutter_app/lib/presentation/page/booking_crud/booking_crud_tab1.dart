import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

import 'calculator/calculator.dart';
import 'widget/amount_display.dart';
import 'widget/date_input.dart';

class BookingCrudTab1 extends StatelessWidget {
  final BookingModel model;
  final VoidCallback onCategoryTap;
  final GlobalKey<AmountDisplayState> amountDisplayKey;

  const BookingCrudTab1({required this.model, required this.onCategoryTap, required this.amountDisplayKey});

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
          AmountDisplay(key: amountDisplayKey),
          const Spacer(),
          Calculator(model: model),
          const SizedBox(height: AppDimensions.verticalPadding * 2),
          SaveButton(text: "booking.choose_category_button", onTap: onCategoryTap, backgroundColor: AppColors.secondaryColor),
          const SizedBox(height: AppDimensions.verticalPadding),
        ],
      );
    });
  }
}
