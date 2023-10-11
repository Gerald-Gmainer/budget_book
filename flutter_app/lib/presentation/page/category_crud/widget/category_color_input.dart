import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';

class CategoryColorInput extends StatelessWidget {
  final IconColorModel colorModel;
  final Function(IconColorModel model) onTap;
  final IconColorModel? selectedColor;

  const CategoryColorInput({required this.colorModel, required this.onTap, required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call(colorModel);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundColor: ColorConverter.stringToColor(colorModel.code),
            radius: 20,
          ),
          if (selectedColor == colorModel)
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
