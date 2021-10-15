import 'package:flutter/material.dart';
import 'package:thesis_auth/src/styles/text.dart';

abstract class Appalerts {
  static Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'error',
              style: TextStyles.subtitle,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    errorMessage,
                    style: TextStyles.body,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Okay',
                  style: TextStyles.body,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }
}
