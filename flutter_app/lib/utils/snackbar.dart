import 'package:flutter/material.dart';
import 'utils.dart';

void showSnackBar(BuildContext? context, String message) {
  if (context == null) {
    BudgetLogger.instance.e("showSnackBar: context is NULL");
    return;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

void showErrorSnackBar(BuildContext? context, String message, {Duration? duration}) {
  if (context == null) {
    BudgetLogger.instance.e("showSnackBar: context is NULL");
    return;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AppColors.errorColor,
      duration: duration ?? Duration(seconds: 4),
    ),
  );
}

class ScaffoldProvider extends ChangeNotifier {
  BuildContext? scaffoldContext;

  void setScaffoldContext(BuildContext ctx) {
    scaffoldContext = ctx;
    // notifyListeners();
  }
}
