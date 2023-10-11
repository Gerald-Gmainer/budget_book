import 'package:flutter/material.dart';

class CategoryNameInput extends StatelessWidget {
  final TextEditingController controller;

  const CategoryNameInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Category Name',
      ),
      validator: (value) {
        if (value?.isNotEmpty == false) {
          return 'Please enter a name';
        }
        return null;
      },
    );
  }

}