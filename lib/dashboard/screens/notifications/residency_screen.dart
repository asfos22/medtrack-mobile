import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/core/residency/residency_form.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/notification_card.dart';

class ResidencyScreen extends StatefulWidget {
  const ResidencyScreen({Key? key}) : super(key: key);

  @override
  _ResidencyScreenState createState() => _ResidencyScreenState();
}

class _ResidencyScreenState extends State<ResidencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16),
          child: DefaultButton(
            text: "Save",
            press: () {},
          ),
        ),
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: NotificationCard(
              title: "Residency information updated successfully",
              backgroundColor: AppConstants.greenColor,
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [ResidencyForm()],
              ),
            ),
          ),
        ));
  }
}
