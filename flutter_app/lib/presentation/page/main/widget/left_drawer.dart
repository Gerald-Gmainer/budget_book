import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

import 'account_filter.dart';
import 'left_drawer_button.dart';

class LeftDrawer extends StatefulWidget {
  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    const double menuWidth = 200.0;
    final menuState = Provider.of<LeftDrawerMenuState>(context);

    return Stack(
      children: [
        IgnorePointer(
          ignoring: !menuState.isMenuOpen,
          child: GestureDetector(
            onTap: () {
              menuState.toggleMenu();
            },
            child: Container(
              color: menuState.isMenuOpen ? Colors.black38 : Colors.transparent,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          top: 0,
          bottom: 0,
          left: menuState.isMenuOpen ? 0 : -menuWidth,
          curve: Curves.easeInOut,
          child: SizedBox(
            width: menuWidth,
            // color: AppColors.secondaryColor,
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: AppDimensions.verticalPadding),
            _buildLabel("main.drawer.account_label"),
            AccountFilter(),
            SizedBox(height: AppDimensions.verticalPadding),
            _buildLabel("main.drawer.period_label"),
            _buildPeriodButton(BudgetPeriod.day, "period.day", false),
            _buildPeriodButton(BudgetPeriod.month, "period.month", true),
            _buildPeriodButton(BudgetPeriod.year, "period.year", false),
            _buildPeriodButton(BudgetPeriod.all, "period.all", false),
            SizedBox(height: AppDimensions.verticalPadding),
            _buildLabel("main.drawer.view_label"),
            _buildChangeViewButton(Icons.pie_chart, 'view.graph', true),
            _buildChangeViewButton(Icons.calendar_today, 'view.calendar', false),
            _buildChangeViewButton(Icons.list, 'view.list', false),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.verticalPadding / 2, horizontal: AppDimensions.horizontalPadding / 2),
      child: Text(text).tr(),
    );
  }

  Widget _buildPeriodButton(BudgetPeriod period, String text, bool isSelected) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.verticalPadding / 2, horizontal: AppDimensions.horizontalPadding),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: AppColors.accentColor,
          side: BorderSide(
            color: isSelected ? AppColors.accentColor : AppColors.secondaryColor,
            width: 1,
          ),
          padding: EdgeInsets.all(12),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppColors.accentColor : AppColors.secondaryTextColor,
            fontWeight: isSelected ? FontWeight.bold : null,
          ),
        ).tr(),
      ),
    );
  }

  Widget _buildChangeViewButton(IconData icon, String text, bool isSelected) {
    return ListTile(
      leading: Icon(icon, size: 28, color: isSelected ? AppColors.accentColor : AppColors.secondaryTextColor),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? AppColors.accentColor : AppColors.secondaryTextColor,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ).tr(),
      onTap: () {
        // Handle item 2 tap
      },
    );
  }
}
