import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/pin_code/numpad.dart';
import 'package:medtrack/dashboard/pin_code/numpad_controller.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/close_button_widget.dart';

class PinCodeUpdateScreen extends StatefulWidget {
  const PinCodeUpdateScreen(
      {Key? key,
      required this.code,
      this.backgroundColor,
      this.placeHolder,
      this.pinPlaceholderColor,
      required this.authModel})
      : super(key: key);

  final String code;
  final String? placeHolder;
  final Color? backgroundColor, pinPlaceholderColor;
  final AuthModel authModel;

  @override
  _PinCodeUpdateScreenState createState() => _PinCodeUpdateScreenState();
}

class _PinCodeUpdateScreenState extends State<PinCodeUpdateScreen> {
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
          // print(_numPadController.code);
        }
      }
    });
  }

  /* main build num pad method. */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: widget.backgroundColor,
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: constraints.copyWith(
                        minHeight: constraints.maxHeight,
                        maxHeight: double.infinity,
                      ),
                      child: IntrinsicHeight(
                        child: NumPad(
                          /* num pad must always have a controller attached to it. */
                          controller: _numPadController,
                          pinInputLength: 4,
                          backgroundColor: widget.backgroundColor!,
                          backKeyFontColor:
                              AppConstants.whiteColor.withOpacity(0.6),
                          pinPlaceholder: widget.placeHolder!,
                          headerLabel: "Enter PIN",
                          pinPlaceholderColor: widget.pinPlaceholderColor,
                          code: widget.code,
                          authModel: widget.authModel,
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.only(top: 32),
                        margin: const EdgeInsets.only(top: 32, right: 16),
                        child: CloseButtonWidget(
                          iconColor: AppConstants.blackColor,
                          backGroundColor: AppConstants.whiteColor,
                          onTab: () => Helper.dismissDialog(context),
                        ),
                      ) // Your footer widget

                      ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Helper.dismissDialog(context),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: const EdgeInsets.all(32),
                            child: Text("Forgot PIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppConstants.subLabelColor)),
                          ) // Your footer widget
                          ),
                    ),
                  ),
                ],
              );
            })));
  }
}
