import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/core/settings/notifications/notification_settings_form.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/repository/network/api_repository.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';
import 'package:medtrack/widgets/custom_settings_default_app_bar.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/loading_view.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  AuthModel authModel = AuthModel();
  bool visible = false;
  List<dynamic> responseErrorListItem = [];
  Map map = {};
  late Future<dynamic> apiCall;

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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomSettingsDefaultAppBar(
              title: "Notifications",
              subTitle: Container(),
              textColor: AppConstants.blackColor,
              backgroundColor: AppConstants.borderLineColor,
            )),
        bottomSheet: Container(
          margin: const EdgeInsets.all(16.0),
          child: visible == false
              ? DefaultButton(
                  text: "Done",
                  press: () {
                    if (authModel.selectedNotification.isNotEmpty) {
                      loadProgress();

                      map = {
                        "notifications": jsonDecode(
                            authModel.selectedNotification.toString())
                      };

                      apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl)
                          .apiParam(
                              map,
                              '',
                              APIConstants.prePendUrl +
                                  APIConstants.patient +
                                  APIConstants.slash +
                                  APIConstants.notificationSettings,
                              APIConstants.postRequestMethod,
                              context);

                      apiCall.then((value) {
                        var responseJson = json.decode(jsonEncode(value));
                        var errorResponse = responseJson['errors'];

                        loadProgress();

                        if (responseJson['notifications'] != null) {
                        } else if (errorResponse != null) {
                          responseErrorListItem.clear();

                          responseErrorListItem.add(errorResponse);
                          CustomAlertDialog(
                              context: context,
                              alertTitle: 'Error Alert',
                              alertContent: responseErrorListItem.toString(),
                              buttonText: 'Ok',
                              buttonAction: () =>
                                  Navigator.pop(context)).createDialog();
                        }
                      }).whenComplete(() => {visible = false});
                    }
                  })
              : const LoadingView(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [NotificationSettingsForm()],
              ),
            ),
          ),
        ));
  }
}
