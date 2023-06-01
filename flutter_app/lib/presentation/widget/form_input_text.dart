import 'package:flutter/material.dart';

class FormInputText extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final bool isLoading;
  final bool obscureText;

  const FormInputText({super.key, required this.controller, required this.label, required this.validator, this.isLoading = false, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: isLoading,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: validator,
    );
  }
}
