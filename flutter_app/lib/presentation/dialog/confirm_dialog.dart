import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ConfirmDialog {
  static void show(
    BuildContext context, {
    required Function onOK,
    Function? onCancel,
    String okText = "dialog.ok",
    String cancelText = "dialog.cancel",
    required String headerText,
    required String bodyText,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(headerText).tr(),
          content: Text(bodyText).tr(),
          actions: <Widget>[
            TextButton(
              child: Text(cancelText).tr(),
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
            ),
            TextButton(
              child: Text(okText).tr(),
              onPressed: () {
                Navigator.of(context).pop();
                onOK.call();
              },
            ),
          ],
        );
      },
    );
  }
}
