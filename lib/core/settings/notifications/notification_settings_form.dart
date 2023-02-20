import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/dashboard/models/notification/notification_settings_model.dart';
import 'package:medtrack/repository/network/api_repository.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';

import '../../../widgets/loading_view.dart';
import 'notification_switch_list_tile.dart';

class NotificationSettingsForm extends StatefulWidget {
  const NotificationSettingsForm({Key? key}) : super(key: key);

  @override
  _NotificationSettingsFormState createState() =>
      _NotificationSettingsFormState();
}

class _NotificationSettingsFormState extends State<NotificationSettingsForm> {
  final _formKey = GlobalKey<FormState>();

  bool prescriptionSwitchControl = false;
  bool investigationSwitchControl = false;

  Future<dynamic>? apiCall;
  bool visible = false;
  List<NotificationItem>? notificationItem = [];
  List<NotificationDatum>? notificationData = [];
  var selectedIndexes = [];
  List<int> availableNotifications = [];
  List<int> selectedNotifications = [];

  bool isSwitched = false;

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
  void initState() {
    executeNotificationSettingCall(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
          margin: const EdgeInsets.only(top: 32),
          child: visible == false
              ? ListView.builder(
                  itemCount: notificationItem!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return ListView(shrinkWrap: true, children: [
                      selectedNotifications
                              .contains(availableNotifications[index])
                          ? NotificationSwitchListTile(
                              notificationItem: notificationItem![index],
                              isSelected: true,
                            )
                          : NotificationSwitchListTile(
                              notificationItem: notificationItem![index],
                              isSelected: false,
                            ),
                    ]);
                  },
                )
              : const LoadingView()),
    );
  }

  void executeNotificationSettingCall(BuildContext context) {
    apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl).apiParam({},'',
        APIConstants.notificationSettingEndpoint,
        APIConstants.getRequestMethod,
        context);

    loadProgress();
    apiCall?.then((value) {
      // var responseJson = json.decode(jsonEncode(value));
      // int statusCode = responseJson['code'];
      //String statusMessage = responseJson['message'];

      var decodeJson = json.decode(jsonEncode(value));
      var decodeJsonData = decodeJson['notifications'];
      var errorResponse = decodeJson['error'];

      if (decodeJsonData != null) {
        setState(() {
          notificationItem = decodeJsonData
              .map<NotificationItem>((json) => NotificationItem.fromJson(json))
              .toList();
          notificationData = decodeJson['data']
              .map<NotificationDatum>(
                  (json) => NotificationDatum.fromJson(json))
              .toList();
          for (var element in notificationData!) {
            selectedNotifications.add(element.notification!.id!);
          }

          for (var element in notificationItem!) {
            availableNotifications.add(element.id!);
          }
        });
      } else if (errorResponse != null) {
        CustomAlertDialog(
            context: context,
            alertTitle: 'Alert Info',
            alertContent: errorResponse != null
                ? errorResponse.toString()
                : "Sorry something happen",
            buttonText: 'Ok',
            buttonAction: () => Navigator.pop(context)).createDialog();
      }
    }).whenComplete(() => {loadProgress()});
  }
}
