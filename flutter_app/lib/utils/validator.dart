import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

extension CustomValidationBuilder on ValidationBuilder {
  password() => add((value) {
        if (value == null) {
          return "Enter a password";
        }
        if (value.length < 8) {
          return "Password should be at least 8 characters";
        }
        if (value == 'password') {
          return 'Password should not "password"';
        }
        return null;
      });

  match(TextEditingController other, [String? message]) => add((value) {
        if (value != other.text) {
          return message ?? "Passwords dont match";
        }
        return null;
      });
}
