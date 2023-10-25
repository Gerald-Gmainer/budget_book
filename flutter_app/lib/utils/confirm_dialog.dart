import 'package:flutter/material.dart';

class ConfirmDialog {
  static void show(
    BuildContext context, {
    required Function onOK,
    Function? onCancel,
    String okText = "OK",
    String cancelText = "Cancel",
    required String headerText,
    required String bodyText,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(headerText),
          content: Text(bodyText),
          actions: <Widget>[
            TextButton(
              child: Text(cancelText),
              onPressed: () {
                onCancel?.call();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(okText),
              onPressed: () {
                onOK.call();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
