import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

class DateQuickButtons extends StatelessWidget {
  final BookingCrudModel crudModel;

  const DateQuickButtons({required this.crudModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 4.0), // Add vertical padding
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "1/10",
                  style: TextStyle(fontSize: 16.0), // Adjust font size
                ),
                Text(
                  "Today",
                  style: TextStyle(color: AppColors.secondaryTextColor), // Different color
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 4.0), // Add vertical padding
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "1/10",
                  style: TextStyle(fontSize: 16.0), // Adjust font size
                ),
                Text(
                  "Yesterday",
                  style: TextStyle(color: AppColors.secondaryTextColor), // Different color
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 4.0), // Add vertical padding
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "1/10",
                  style: TextStyle(fontSize: 16.0), // Adjust font size
                ),
                Text(
                  "2 days ago",
                  style: TextStyle(color: AppColors.secondaryTextColor), // Different color
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
