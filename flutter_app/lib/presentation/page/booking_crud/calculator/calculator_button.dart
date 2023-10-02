import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

import 'calculator_key.dart';

class CalculatorButton extends StatelessWidget {
  final CalculatorKey calculatorKey;
  final Function(CalculatorKey) onPressed;
  final Widget? icon;
  final Color backgroundColor;
  final Color fontColor;

  const CalculatorButton({
    required this.calculatorKey,
    required this.onPressed,
    this.icon,
    this.backgroundColor = AppColors.secondaryColor,
    this.fontColor = AppColors.primaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed.call(calculatorKey);
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: backgroundColor,
      ),
      child: _buildKey(),
    );
  }

  Widget _buildKey() {
    if (icon != null) {
      return _buildIcon();
    }
    return OverflowBox(
      alignment: Alignment.center,
      maxWidth: double.infinity,
      child: Text(
        calculatorKey.displayText,
        maxLines: 1,
        textAlign: TextAlign.left,
        softWrap: false,
        overflow: TextOverflow.visible,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: fontColor),
      ),
    );
  }

  Widget _buildIcon() {
    return icon!;
  }
}
