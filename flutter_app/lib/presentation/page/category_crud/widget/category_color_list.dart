import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';

import 'category_color_input.dart';

class CategoryColorList extends StatelessWidget {
  final List<IconColorModel> categoryColors;
  final Function(IconColorModel model) onTap;
  final IconColorModel? selectedColor;

  const CategoryColorList({required this.categoryColors, required this.onTap, required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("category.select_color_label".tr(), style: TextStyle(fontSize: 16)),
        SizedBox(
          height: 60, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryColors.length,
            itemBuilder: (BuildContext context, int index) {
              final color = categoryColors[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CategoryColorInput(
                  colorModel: color,
                  selectedColor: selectedColor,
                  onTap: onTap,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
