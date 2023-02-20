import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/screens/auth/registration/register_screen.dart';
import 'package:medtrack/dashboard/screens/pin_code/pin_code_screen.dart';
import 'package:medtrack/repository/utils/country_picker.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/form_error.dart';
import 'package:medtrack/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool remember = false;
  List<dynamic> listItem = [];
  List<dynamic> responseErrorListItem = [];
  final List<String> errors = [];
  AuthModel authModel = AuthModel();

  bool visible = false;

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

  void _callBackFunction(
      String? name, String dialCode, String code, String? flag) {
    setState(() {
      // phone dia code
      authModel.setCountryCode = dialCode;
      //print(name! + " " + dialCode + " " + flag!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "Sign In",
              subTitle: Row(
                children: [
                  Text("Don't have an account ",
                      style: TextStyle(
                          fontSize: 16, color: AppConstants.subLabelColor)),
                  GestureDetector(
                      onTap: () {
                        Helper.navigateToNextPage(
                            context, const RegisterScreen());
                      },
                      child: Text(
                        "Register?",
                        style: TextStyle(
                            fontSize: 16, color: AppConstants.primaryColor),
                      ))
                ],
              ),
              textColor: AppConstants.blackColor,
              backgroundColor: AppConstants.backgroundColor,
            )),
        body: SafeArea(
            child: Stack(children: <Widget>[
          SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.only(
                    left: 24.0, top: 16, right: 24, bottom: 90.0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Wrap(
                      children: <Widget>[
                        Column(
                          children: [
                            loginForm(context),
                            FormError(errors: errors),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                        // Your fixed Footer here,
                      ],
                    ))),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 64.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  children: <Widget>[
                    Column(
                      children: [
                        DefaultButton(
                          text: "NEXT",
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!
                                  .save();

                              Navigator.of(context).pop();
                             Helper.navigateToNextPage(
                                  context,
                                  PinCodeScreen(
                                      headerLabelHolder: "Confirm your PIN",
                                      placeHolder: '',
                                      code: AppConstants.pinCodeConfirm,
                                      backgroundColor:
                                          AppConstants.primaryColor,
                                      authModel: authModel));
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DefaultButton(
                          text: "Forgot Sign in details?",
                          backGroundColor: AppConstants.whiteColor,
                          textColor: AppConstants.blackColor,
                          press: () {
                            /*Helper.navigateToNextPage(
                  context,
                  PinCodeScreen(
                      code: AppConstants.pinCodeConfirm,
                      backgroundColor: AppConstants.primaryColor));*/
                          },
                        )
                      ],
                    ),
                    // Your fixed Footer here,
                  ],
                )),
          )
        ])));
  }

  TextInputField phoneNumberTextInputField() {
    return TextInputField(
      label: "Phone Number",
      keyboardType: TextInputType.phone,
      obscure: false,
      onSaved: (newValue) => authModel.setPhone = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  Widget loginForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Phone number",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal)),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CountryPicker(
                          callBackFunction: _callBackFunction,
                          headerText: 'Select Country',
                          headerBackgroundColor: AppConstants.whiteColor,
                          headerTextColor: AppConstants.whiteColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 7,
                        child: phoneNumberTextInputField(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
