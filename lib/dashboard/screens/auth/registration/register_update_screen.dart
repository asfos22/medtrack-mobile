import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/core/auth/register/account_update_form.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';

class RegisterUpdateScreen extends StatefulWidget {
  final AuthModel authModel;

  const RegisterUpdateScreen({Key? key, required this.authModel})
      : super(key: key);

  @override
  _RegisterUpdateScreenState createState() => _RegisterUpdateScreenState();
}

class _RegisterUpdateScreenState extends State<RegisterUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "Personal Info",
              subTitle: Container(),
              textColor: AppConstants.blackColor,
              backgroundColor: AppConstants.backgroundColor,
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [AccountUpdateForm(authModel: widget.authModel)],
              ),
            ),
          ),
        ));
  }
}
