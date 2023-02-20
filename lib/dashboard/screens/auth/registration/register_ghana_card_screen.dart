import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/core/auth/register/register_ghana_card_form.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/widgets/card_main.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';

class RegisterGhanaCardScreen extends StatefulWidget {
  const RegisterGhanaCardScreen({Key? key, required this.authModel})
      : super(key: key);

  final AuthModel authModel;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterGhanaCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "Connect your\nGhana Card",
              subTitle: Container(),
              textColor: AppConstants.blackColor,
              backgroundColor: AppConstants.backgroundColor,
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              margin: const EdgeInsets.only(left: 0.0, right: 16.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CardMain(
                      title: "Why we use your Ghana card",
                      description:
                          "We use your Ghana ard to verify your identify and for you to secure access to medical records nationwide.",
                      color: AppConstants.subLabelColor.withOpacity(0.1)),
                  const SizedBox(
                    height: 16,
                  ),
                  RegisterGhanaCardForm(authModel: widget.authModel),
                ],
              ),
            ),
          ),
        ));
  }
}
