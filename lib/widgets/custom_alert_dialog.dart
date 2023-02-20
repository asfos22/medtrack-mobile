import 'package:flutter/material.dart';

class CustomAlertDialog {
  BuildContext context;
  String alertTitle;
  String alertContent;
  String buttonText;
  void Function() buttonAction;
  bool? barrierDismissible = false;

  CustomAlertDialog(
      {required this.context,
      required this.alertTitle,
      required this.alertContent,
      required this.buttonText,
      required this.buttonAction,
      this.barrierDismissible});

  createDialog() async {
    await Future.delayed(const Duration(microseconds: 1));
    showDialog(
        barrierDismissible: barrierDismissible ?? false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              alertTitle,
            ),
            content: Text(
              alertContent,
            ),
            elevation: 0.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            actions: <Widget>[
              MaterialButton(
                onPressed: buttonAction,
                child: Text(
                  buttonText,
                ),
              )
            ],
          );
        });
  }
}
