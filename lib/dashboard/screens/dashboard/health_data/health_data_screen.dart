import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/core/health_data/health_data_form.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';

class HealthDataScreen extends StatefulWidget {
  const HealthDataScreen({Key? key, required this.authModel}) : super(key: key);
  final AuthModel authModel;

  @override
  _HealthDataScreenState createState() => _HealthDataScreenState();
}

class _HealthDataScreenState extends State<HealthDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "Health Data",
              subTitle: Container(),
              textColor: AppConstants.whiteColor,
              backgroundColor: AppConstants.primaryColor,
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              margin: const EdgeInsets.only(left: 0.0, right: 0.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HealthDataForm(authModel: widget.authModel),
                ],
              ),
            ),
          ),
        ));
  }
}
