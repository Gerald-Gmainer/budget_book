import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

class NumberKey extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color fontColor;

  const NumberKey({
    required this.text,
    this.backgroundColor = AppColors.secondaryColor,
    this.fontColor = AppColors.primaryTextColor,
  });

  _onPressed() {}

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        text,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.visible,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: fontColor),
      ),
    );
  }
}
