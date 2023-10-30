import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryIconInput extends StatefulWidget {
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

  @override
  State<CategoryIconInput> createState() => _CategoryIconInputState();
}

class _CategoryIconInputState extends State<CategoryIconInput> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.selectedIcon == widget.iconModel) {
        if (!mounted) return;
        Scrollable.ensureVisible(context);
      }
    });
  }

  _onTap() {
    widget.onTap.call(widget.iconModel);
  }

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.secondaryColor;
    bool showBorder = widget.selectedIcon == widget.iconModel;
    if (widget.selectedIcon == widget.iconModel && widget.selectedColor != null) {
      color = ColorConverter.stringToColor(widget.selectedColor!.code);
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
            IconConverter.getIconFromModel(widget.iconModel),
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
