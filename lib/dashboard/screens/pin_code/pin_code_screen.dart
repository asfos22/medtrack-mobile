import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/pin_code/numpad.dart';
import 'package:medtrack/dashboard/pin_code/numpad_controller.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen(
      {Key? key,
      required this.code,
      this.headerLabelHolder,
      this.placeHolder,
      this.backgroundColor,
      this.pinPlaceholderColor,
      required this.authModel})
      : super(key: key);

  final String code;
  final String? headerLabelHolder, placeHolder;

  final Color? backgroundColor, pinPlaceholderColor;
  final AuthModel authModel;

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final NumPadController _numPadController = NumPadController();

  @override
  void initState() {
    super.initState();
    /* Listener for the num  pad controller. */
    _numPadController.addListener(() {
      String realCode = "";
      if (_numPadController.doneTyping) {
        if (realCode != _numPadController.code) {
          _numPadController.wrongInputBehavior();
          print("PIN CODE");
          print(_numPadController.code);
        }
      }
    });
  }

  /* main build num pad method. */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.backgroundColor,
        body: NumPad(
          /* num pad must always have a controller attached to it. */
          controller: _numPadController,
          pinInputLength: 6,
          backgroundColor: widget.backgroundColor!,
          backKeyFontColor: AppConstants.whiteColor.withOpacity(0.6),
          pinPlaceholder:
              widget.placeHolder ?? "Secure your account with a 4-digit PIN",
          headerLabel: widget.headerLabelHolder ?? "Create a PIN",
          pinPlaceholderColor: widget.pinPlaceholderColor,
          code: widget.code,
          authModel: widget.authModel,
        ));
  }
}
