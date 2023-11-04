import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CategoryNameInput extends StatelessWidget {
  final TextEditingController controller;
  AutovalidateMode? autovalidateMode;

  CategoryNameInput({required this.controller, this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "category.name_label".tr(),
      ),
      autovalidateMode: autovalidateMode,
      validator: (value) {
        if (value?.isNotEmpty == false) {
          return "category.validation.required_name".tr();
        }
        return null;
      },
    );
  }
}
