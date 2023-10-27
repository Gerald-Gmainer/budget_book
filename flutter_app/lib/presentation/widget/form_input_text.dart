import 'package:flutter/material.dart';

class FormInputText extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final bool isLoading;
  final AutovalidateMode? autovalidateMode;

  const FormInputText({
    required this.controller,
    required this.label,
    required this.validator,
    this.isLoading = false,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: isLoading,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: validator,
    );
  }
}
