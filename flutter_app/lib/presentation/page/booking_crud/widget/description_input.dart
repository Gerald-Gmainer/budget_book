import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/app_colors.dart';
import 'package:flutter_app/utils/app_dimensions.dart';

class DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding),
      child: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.edit),
          labelText: 'Note',
        ),
      ),
    );
  }
}
