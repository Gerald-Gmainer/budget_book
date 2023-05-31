import 'package:form_validator/form_validator.dart';

extension CustomValidationBuilder on ValidationBuilder {
  password() => add((value) {
    if (value == 'password') {
      return 'Password should not "password"';
    }
    return null;
  });
}