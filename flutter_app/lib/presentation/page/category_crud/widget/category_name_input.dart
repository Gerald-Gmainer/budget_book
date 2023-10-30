import 'package:flutter/material.dart';

class CategoryNameInput extends StatelessWidget {
  final TextEditingController controller;
  AutovalidateMode? autovalidateMode;

  CategoryNameInput({required this.controller, this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Category Name',
      ),
      autovalidateMode: autovalidateMode,
      validator: (value) {
        if (value?.isNotEmpty == false) {
          return 'Please enter a name';
        }
        return null;
      },
    );
  }

}