import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/utils.dart';
import 'dart:math' as math;

import 'category_icon_input.dart';

class CategoryIconList extends StatelessWidget {
  final int rowsCount = 3;
  final List<IconDataModel> categoryIcons;
  final Function(IconDataModel icon) onTap;
  final IconDataModel? selectedIcon;
  final IconColorModel? selectedColor;

  const CategoryIconList({
    required this.categoryIcons,
    required this.onTap,
    this.selectedIcon,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Select an Icon', style: TextStyle(fontSize: 16)),
        Container(
          height: 250,
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.verticalPadding),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ((categoryIcons.length) / rowsCount).ceil(),
            itemBuilder: (BuildContext context, int rowIndex) {
              final startIndex = rowIndex * rowsCount;
              final endIndex = math.min(startIndex + rowsCount, (categoryIcons.length));
              final iconsForRow = categoryIcons.sublist(startIndex, endIndex);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: iconsForRow.map((icon) {
                  return CategoryIconInput(
                    iconModel: icon,
                    onTap: onTap,
                    selectedColor: selectedColor,
                    selectedIcon: selectedIcon,
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
