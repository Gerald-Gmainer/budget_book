import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String? text;
  final VoidCallback onTap;

  const CategoryIcon({required this.onTap, required this.icon, required this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: color,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            onTap: onTap,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final iconSize = constraints.maxWidth;
                return SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: Center(
                    child: Icon(
                      icon,
                      size: iconSize * 0.5,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (text != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              text!,
              style: const TextStyle(color: AppColors.primaryTextColor),
            ),
          ),
      ],
    );
  }
}
