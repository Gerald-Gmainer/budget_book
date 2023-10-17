import 'package:flutter/material.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

import 'account_select.dart';
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
            _buildLabel("Account"),
            AccountSelect(),
            SizedBox(height: AppDimensions.verticalPadding),
            _buildLabel("Period"),
            _buildPeriodButton(BudgetPeriod.day, "Day", false),
            _buildPeriodButton(BudgetPeriod.month, "Month", true),
            _buildPeriodButton(BudgetPeriod.year, "Year", false),
            _buildPeriodButton(BudgetPeriod.all, "All", false),
            SizedBox(height: AppDimensions.verticalPadding),
            _buildLabel("View"),
            _buildChangeViewButton(Icons.pie_chart, 'Graph', true),
            _buildChangeViewButton(Icons.calendar_today, 'Calendar', false),
            _buildChangeViewButton(Icons.list, 'List', false),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.verticalPadding / 2, horizontal: AppDimensions.horizontalPadding / 2),
      child: Text(text),
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
        ),
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
      ),
      onTap: () {
        // Handle item 2 tap
      },
    );
  }
}
