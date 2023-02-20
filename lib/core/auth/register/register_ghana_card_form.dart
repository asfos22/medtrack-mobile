import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/screens/pin_code/pin_code_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/form_error.dart';
import 'package:medtrack/widgets/text_input.dart';

class RegisterGhanaCardForm extends StatefulWidget {
  const RegisterGhanaCardForm({Key? key, required this.authModel})
      : super(key: key);

  final AuthModel authModel;

  @override
  _RegisterGhanaCardFormState createState() => _RegisterGhanaCardFormState();
}

class _RegisterGhanaCardFormState extends State<RegisterGhanaCardForm> {
  final _formKey = GlobalKey<FormState>();
  bool remember = false;
  List<dynamic> listItem = [];
  List<dynamic> responseErrorListItem = [];
  final List<String> errors = [];
  Map map = {};
  bool visible = false;

  late String ghanaCode = '', threeCode = '', sixCode = '';

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

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  late FToast fToast;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          color: AppConstants.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Ghana Card Number",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal)),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: countryCodeTextInputField(),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 4,
                              child: sixCodeTextInputField(),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 3,
                              child: threeCodeTextInputField(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FormError(errors: errors),
                  const SizedBox(height: 24),
                  DefaultButton(
                    text: "NEXT",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Helper.navigateToNextPage(
                            context,
                            PinCodeScreen(
                              placeHolder: "* * * *",
                              code: AppConstants.pinCodeCreate,
                              backgroundColor: AppConstants.primaryColor,
                              pinPlaceholderColor: AppConstants.subLabelColor,
                              authModel: widget.authModel,
                            ));
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: Helper.getScreenWidth(context),
                    margin: const EdgeInsets.all(0.0),
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.borderLineColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: DefaultButton(
                      text: "I don't have a Ghana card",
                      backGroundColor: AppConstants.whiteColor.withOpacity(0.9),
                      textColor: AppConstants.blackColor,
                      press: () {
                        //Helper.navigateToNextPage(
                        //    context, const LoginScreen());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  TextInputField countryCodeTextInputField() {
    return TextInputField(
      label: "GHA",
      maxLength: 3,
      keyboardType: TextInputType.text,
      obscure: false,
      onSaved: (newValue) => {},
      onChanged: (value) {
        setState(() {
          widget.authModel.setGhanaCardCode = value;
        });
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kGhanaCardCodeNullError);
        } else if (value.length <= 3) {
          removeError(error: AppConstants.kGhanaCardCodeNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kGhanaCardCodeNullError);
          return "";
        } else if (value.length > 4) {
          addError(error: AppConstants.kGhanaCardCodeNullError);
          return '';
        }
        return null;
      },
      onTap: () {},
    );
  }

  TextInputField sixCodeTextInputField() {
    return TextInputField(
      label: "000 000",
      maxLength: 6,
      obscure: false,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => {},
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kSixSeriesNullError);
          widget.authModel.setGhanaSerialSixCode = value;
        } else if (value.length <= 6) {
          removeError(error: AppConstants.kSixSeriesNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kSixSeriesNullError);
          return "";
        } else if (value.length > 6) {
          addError(error: AppConstants.kSixSeriesNullError);
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  //--

  TextInputField threeCodeTextInputField() {
    return TextInputField(
      label: "000",
      maxLength: 3,
      obscure: false,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => {},
      onChanged: (value) {
        if (value.isNotEmpty) {
          widget.authModel.setGhanaSerialThreeCode = value;
          removeError(error: AppConstants.kThreeSeriesNullError);
        } else if (value.length <= 3) {
          removeError(error: AppConstants.kThreeSeriesNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kThreeSeriesNullError);
          return "";
        } else if (value.length > 4) {
          addError(error: AppConstants.kThreeSeriesNullError);
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }
}
