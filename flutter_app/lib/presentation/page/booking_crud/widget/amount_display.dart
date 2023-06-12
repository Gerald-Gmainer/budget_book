import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_colors.dart';

class AmountDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("2+4", style: TextStyle(fontSize: 26, color: AppColors.primaryTextColor)),
            Text("6", style: TextStyle(fontSize: 44, color: AppColors.primaryTextColor)),
          ],
        ),
      ),
    );
  }
}
