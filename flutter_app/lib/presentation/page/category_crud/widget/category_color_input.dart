import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryColorInput extends StatefulWidget {
  final IconColorModel colorModel;
  final Function(IconColorModel model) onTap;
  final IconColorModel? selectedColor;

  const CategoryColorInput({required this.colorModel, required this.onTap, required this.selectedColor});

  @override
  State<CategoryColorInput> createState() => _CategoryColorInputState();
}

class _CategoryColorInputState extends State<CategoryColorInput> {
  @override
  initState() {
    super.initState();
    BudgetLogger.instance.d(widget.selectedColor?.code);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.selectedColor == widget.colorModel) {
        if (!mounted) return;
        Scrollable.ensureVisible(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap.call(widget.colorModel);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundColor: ColorConverter.stringToColor(widget.colorModel.code),
            radius: 20,
          ),
          if (widget.selectedColor == widget.colorModel)
            Positioned.fill(
              child: Center(
                child: Text(
                  String.fromCharCode(Icons.check.codePoint),
                  style: TextStyle(
                    inherit: false,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: Icons.space_dashboard_outlined.fontFamily,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
