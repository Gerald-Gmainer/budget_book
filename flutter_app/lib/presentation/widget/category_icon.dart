import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryIcon extends StatelessWidget {
  static const double circleSize = 60;
  static const double iconSize = 30;
  static const double horizontalPadding = AppDimensions.horizontalPadding;
  static const double verticalPadding = 8;
  final IconData icon;
  final Color color;
  final String? text;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryIcon({
    required this.onTap,
    required this.icon,
    required this.color,
    this.isSelected = false,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(builder: (context, constraints) {
        double buttonWidth = constraints.maxWidth / 3 - 2 - horizontalPadding;

        return Container(
          width: buttonWidth,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: AppColors.primaryTextColor, width: 1) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Text(
                  text ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: AppColors.primaryTextColor),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
