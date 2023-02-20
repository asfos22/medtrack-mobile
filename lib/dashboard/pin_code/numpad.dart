import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/screens/auth/registration/register_complete_screen.dart';
import 'package:medtrack/dashboard/screens/dashboard/home_screen.dart';
import 'package:medtrack/dashboard/screens/pin_code/pin_code_confirm_update_screen.dart';
import 'package:medtrack/repository/network/api_repository.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';
import 'package:medtrack/widgets/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

import './numpad_controller.dart';
import './numpad_keyboard.dart';
import './pin_input_field.dart';

/* Num pad widget */
class NumPad extends StatefulWidget {
  final TextEditingController pinInputController = TextEditingController();

  /* Constructor Parameters. */
  final NumPadController controller;

  final Color backgroundColor, keyColor, clearKeyBackgroundColor;
  final Color backKeyBackgroundColor, pinInputFieldColor, numPadFontColor;
  final Color? backKeyFontColor, clearKeyFontColor, pinPlaceholderColor;

  final int pinInputLength; // Limit how many characters can be typed.
  final String pinPlaceholder, headerLabel;
  final String? code;
  final AuthModel authModel;

  NumPad(
      {Key? key,
      required this.controller,
      this.backgroundColor = const Color(0xFF3952A6),
      this.keyColor = Colors.black26,
      this.clearKeyBackgroundColor = Colors.black38,
      this.clearKeyFontColor = Colors.white,
      this.backKeyBackgroundColor = Colors.black38,
      this.backKeyFontColor = Colors.white,
      this.numPadFontColor = Colors.white,
      this.pinInputFieldColor = Colors.black,
      this.pinInputLength = 4,
      required this.pinPlaceholder,
      this.pinPlaceholderColor,
      this.code,
      required this.headerLabel,
      required this.authModel})
      : super(key: key);

  @override
  _NumPadState createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  TextEditingController? inputController;

  /* Listeners */
  void Function()? inputControllerListener, animControllerListener;

  late var command = AppConstants.pinCodeCreate;

  late Future<dynamic> apiCall;

  bool visible = false;
  Map map = {};
  List<dynamic> responseErrorListItem = [];

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    animationController!.removeListener(animControllerListener!);
    inputController!.removeListener(inputControllerListener!);
    //animation.removeListener(animationStatusListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    int pinInputLength = widget.pinInputLength;
    inputController = widget.pinInputController;

    /* Listeners. */
    inputControllerListener = () {
      widget.controller.code = inputController!.text;
      if (inputController!.text.length >= pinInputLength) {
        widget.controller.doneTyping = true;

        var command = widget.code;
        print("CODE INPUT DONE DONE!!");
        // print(widget.controller.code.toString());

        widget.authModel.setPin = widget.controller.code.toString();

        print(command);
        switch (command) {
          case AppConstants.pinCodeCreate:
            // executeClosed();
            Helper.navigateToNextPage(
                context, RegisterCompleteScreen(authModel: widget.authModel));

            break;
          case AppConstants.pinCodeConfirm:
            // executePending();
            String countryCode = widget.authModel.getCountryCode().toString();
            String phoneNumber = widget.authModel.getPhone().toString();

            loadProgress();
            map = {
              "user": {
                "login_id": '$countryCode$phoneNumber',
                "pin": widget.authModel.getPin()
              }
            };

            apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl).apiParam(
                map,'',
                APIConstants.prePendUrl +
                    APIConstants.patient +
                    APIConstants.login,
                "POST",
                context);

            apiCall.then((value) {
              var responseJson = json.decode(jsonEncode(value));

              var errorResponse = responseJson['error'];
              var successResponse = responseJson['success'];

              if (successResponse == 1) {
                if (responseJson['token'] != null) {
                  widget.authModel.setUserToken =
                      responseJson['token'].toString();
                  widget.authModel.setFullName =
                      responseJson['patient']['name'].toString();
                  widget.authModel.setGhanaCardNumber =
                      responseJson['patient']['ghana_card_number'].toString();
                }
                Navigator.of(context).pop();
                Helper.showActionModalBottomSheet(
                    context, true, const HomeScreen());
              } else if (errorResponse != null) {
                responseErrorListItem.clear(); // clear list
                responseErrorListItem.add(errorResponse.toString());
                CustomAlertDialog(
                    context: context,
                    alertTitle: 'Alert Info',
                    alertContent: responseErrorListItem
                        .toString()
                        .replaceAll(RegExp(r'[^\w\s]+'), ''),
                    buttonText: 'Ok',
                    buttonAction: () => Navigator.pop(context)).createDialog();
              }
            }).whenComplete(() => {loadProgress()});
            break;
          case AppConstants.pinCodeUpdateCreate:
            Helper.navigateToNextPage(
                context,
                PinCodeConfirmUpdateScreen(
                  placeHolder: "* * * *",
                  code: AppConstants.pinCodeUpdateCreate,
                  backgroundColor: AppConstants.blackColor,
                  authModel: widget.authModel,
                ));

            break;
          default:
            Helper.navigateToNextPage(
                context, RegisterCompleteScreen(authModel: widget.authModel));
        }
      }
    };
    animControllerListener = () => setState(() {});

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(animControllerListener!);

    inputController!.addListener(inputControllerListener!);

    NumPadController.shakeAnimation = animationController;
  }

  vector_math.Vector3 _shake() {
    double progress = animationController!.value;
    double offset = sin(progress * pi * 800000.0);
    offset = double.parse(offset.toStringAsFixed(2));

    return vector_math.Vector3(offset * 10, 0.0, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<TextEditingController>.value(
      value: widget.pinInputController,
      child: visible == false
          ? Center(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /* Pin Input Field Container */
                  Icon(Icons.lock, color: AppConstants.whiteColor),
                  const SizedBox(height: 8.0),
                  Text(widget.headerLabel,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.subLabelColor)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Provider<vector_math.Vector3>.value(
                        value: _shake(),
                        child: PinInputField(
                          placeholder: widget.pinPlaceholder,
                          placeholderColor: widget.pinPlaceholderColor,
                          color: AppConstants.whiteColor,
                        )),
                  ),
                  const SizedBox(height: 16.0),
                  /* Num pad Keyboard Container. */
                  NumPadKeyboard(
                    keyColor: widget.keyColor,
                    clearKeyBackgroundColor: widget.clearKeyBackgroundColor,
                    backKeyBackgroundColor: widget.backKeyBackgroundColor,
                    backKeyFontColor: widget.backKeyFontColor,
                    clearKeyFontColor: widget.clearKeyFontColor,
                    keyFontColor: widget.numPadFontColor,
                    pinInputController: widget.pinInputController,
                    pinInputLength: widget.pinInputLength,
                    numPadController: widget.controller,
                  ),
                ],
              )),
            )
          : const LoadingView(),
    );
  }
}
