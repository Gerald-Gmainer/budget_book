import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_dimensions.dart';

class ChooseCategoryButton extends StatelessWidget {
  _onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppDimensions.verticalPadding),
      child: ElevatedButton(
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
        ),
        child: Text("choose category", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
