import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormInputPassword extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final bool isLoading;
  final AutovalidateMode? autovalidateMode;

  const FormInputPassword({
    required this.controller,
    required this.label,
    required this.validator,
    this.isLoading = false,
    this.autovalidateMode,
  });

  @override
  State<FormInputPassword> createState() => _FormInputPasswordState();
}

class _FormInputPasswordState extends State<FormInputPassword> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.isLoading,
      obscureText: !_showPassword,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        errorMaxLines: 4,
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? FontAwesomeIcons.solidEye : FontAwesomeIcons.solidEyeSlash, size: 14),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}
