import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/models/auth/dob_model.dart';
import 'package:medtrack/dashboard/screens/auth/registration/register_update_screen.dart';
import 'package:medtrack/dashboard/screens/notifications/medtrack_id_screen.dart';
import 'package:medtrack/dashboard/screens/notifications/notification_settings_screen.dart';
import 'package:medtrack/dashboard/screens/notifications/residency_screen.dart';
import 'package:medtrack/dashboard/screens/pin_code/pin_code_update_screen.dart';
import 'package:medtrack/repository/network/api_repository.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';
import 'package:medtrack/widgets/list_tile_widget.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key, required this.authModel}) : super(key: key);

  final AuthModel authModel;

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  Future<dynamic>? apiCall;
  bool visible = false;

  AuthModel authModel = AuthModel();
  DoBModel doBModel = DoBModel();

  @override
  void initState() {
    //--
    executeProfileCall(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTileWidget(
                    icon: SvgPicture.asset(
                        Helper.getAssetSVGName("iconDarkId", "svg")),
                    title: "MedTrack ID",
                    subTitle: authModel.getGhanaCardNumber().toString(),
                    onTab: () {
                      Helper.navigateToNextPage(context,
                          MedTrackIDScreen(authModel: widget.authModel));
                    },
                    backGroundColor: AppConstants.artBoardBackground,
                    trailingIcon: Icons.arrow_forward_ios_outlined,
                  ),
                  ListTileWidget(
                    icon: SvgPicture.asset(
                        Helper.getAssetSVGName("iconDarkPerson", "svg")),
                    title: "Personal Information",
                    subTitle: "Update your email, phone number etc",
                    onTab: () {
                      Helper.navigateToNextPage(
                          context, RegisterUpdateScreen(authModel: authModel));
                    },
                    backGroundColor: AppConstants.artBoardBackground,
                    trailingIcon: Icons.arrow_forward_ios_outlined,
                  ),
                  ListTileWidget(
                    icon: SvgPicture.asset(
                        Helper.getAssetSVGName("iconDarkLocation", "svg")),
                    title: "Residency",
                    subTitle: "Update your residency information",
                    onTab: () {
                      Helper.navigateToNextPage(
                          context, const ResidencyScreen());
                    },
                    backGroundColor: AppConstants.artBoardBackground,
                    trailingIcon: Icons.arrow_forward_ios_outlined,
                  ),
                  ListTileWidget(
                    icon: SvgPicture.asset(
                        Helper.getAssetSVGName("iconDarkNotification", "svg")),
                    title: "Notifications",
                    subTitle: "Change notifications preferences",
                    onTab: () {
                      Helper.navigateToNextPage(
                          context, const NotificationSettingsScreen());
                    },
                    backGroundColor: AppConstants.artBoardBackground,
                    trailingIcon: Icons.arrow_forward_ios_outlined,
                  ),
                  ListTileWidget(
                    icon: SvgPicture.asset(
                        Helper.getAssetSVGName("iconDarkLock", "svg")),
                    title: "PIN Code",
                    subTitle: "Change PIN Code",
                    onTab: () {
                      Helper.navigateToNextPage(
                          context,
                          PinCodeUpdateScreen(
                              placeHolder: "* * * *",
                              code: AppConstants.pinCodeUpdateCreate,
                              backgroundColor: AppConstants.blackColor,
                              authModel: widget.authModel));
                    },
                    backGroundColor: AppConstants.artBoardBackground,
                    trailingIcon: Icons.arrow_forward_ios_outlined,
                  ),
                ])));
  }

  void executeProfileCall(BuildContext context) {
    //Map map = Map();

    //loadProgress();

    apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl).apiParam({},'',
        APIConstants.fetchProfileEndpoint,
        APIConstants.getRequestMethod,
        context);

    apiCall?.then((value) {
      // var responseJson = json.decode(jsonEncode(value));
      // int statusCode = responseJson['code'];
      //String statusMessage = responseJson['message'];

      print(value.toString());

      var decodeJson = json.decode(jsonEncode(value));
      var decodeJsonData = decodeJson['patient'];
      var errorResponse = decodeJson['error'];

      if (decodeJsonData != null) {
        setState(() {
          authModel.setFullName = decodeJsonData['name'].toString();
          authModel.setGhanaCardNumber =
              decodeJsonData['ghana_card_number'].toString();
          authModel.setEmail = decodeJsonData['email'].toString();

          authModel.setGender = decodeJsonData['gender'].toString();
          doBModel.setDoB = decodeJsonData['date_of_birth'].toString();
          authModel.setPhone = decodeJsonData['phone'].toString();
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
    }).whenComplete(() => {});
  }
}
