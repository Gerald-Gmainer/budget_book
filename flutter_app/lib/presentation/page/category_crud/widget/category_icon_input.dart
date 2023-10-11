import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryIconInput extends StatelessWidget {
  final IconDataModel iconModel;
  final Function(IconDataModel icon) onTap;
  final IconDataModel? selectedIcon;
  final IconColorModel? selectedColor;

  const CategoryIconInput({
    required this.iconModel,
    required this.onTap,
    this.selectedColor,
    this.selectedIcon,
  });

  _onTap() {
    onTap.call(iconModel);
  }

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.secondaryColor;
    bool showBorder = selectedIcon == iconModel;
    if (selectedIcon == iconModel && selectedColor != null) {
      color = ColorConverter.stringToColor(selectedColor!.code);
    }

    return InkWell(
      onTap: _onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
          border: showBorder ? Border.all(color: AppColors.primaryTextColor, width: 1) : null,
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            IconConverter.getIconData(iconModel.name),
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
