import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/app_dimensions.dart';
import 'package:flutter_app/utils/logger.dart';

class ChooseCategoryButton extends StatelessWidget {
  final BookingCrudModel model;
  final VoidCallback onPressed;

  const ChooseCategoryButton({required this.model, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed.call();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
        ),
        child: const Text("choose category", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
