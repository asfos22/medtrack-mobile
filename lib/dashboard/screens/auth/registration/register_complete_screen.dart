import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/walk_through/option_screen.dart';
import 'package:medtrack/repository/network/api_repository.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/loading_view.dart';
import 'package:medtrack/widgets/outlined_button_widget.dart';

class RegisterCompleteScreen extends StatefulWidget {
  const RegisterCompleteScreen({Key? key, required this.authModel})
      : super(key: key);
  final AuthModel authModel;

  @override
  _RegisterCompleteScreenState createState() => _RegisterCompleteScreenState();
}

class _RegisterCompleteScreenState extends State<RegisterCompleteScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.primaryColor,
        body: SafeArea(
            child: ListView(
          children: [
            Center(
              child: Container(
                  margin: const EdgeInsets.all(32.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(Helper.getAssetSVGName(
                                "medTrackLogoIcon", "svg")),
                            const SizedBox(
                              height: 24,
                            ),
                            Text("Setup\nCompleted",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppConstants.whiteColor,
                                    fontFamily: 'Roboto',
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 16,
                            ),
                            Text("You can now track your ...",
                                style: TextStyle(
                                  color:
                                      AppConstants.whiteColor.withOpacity(0.5),
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        ListTile(
                          leading: OutLinedButtonWidget(
                            icon: Icon(Icons.check,
                                color: AppConstants.whiteColor),
                            borderColor: AppConstants.borderLineColor,
                            backGroundColor: AppConstants.greenColor,
                          ),
                          title: Text("Clinical History",
                              style: TextStyle(
                                color: AppConstants.whiteColor.withOpacity(0.5),
                                fontSize: 14,
                              )),
                        ),
                        ListTile(
                          leading: OutLinedButtonWidget(
                            icon: Icon(Icons.check,
                                color: AppConstants.whiteColor),
                            borderColor: AppConstants.borderLineColor,
                            backGroundColor: AppConstants.greenColor,
                          ),
                          title: Text("Clinical History",
                              style: TextStyle(
                                color: AppConstants.whiteColor.withOpacity(0.5),
                                fontSize: 14,
                              )),
                        ),
                        ListTile(
                          leading: OutLinedButtonWidget(
                            icon: Icon(Icons.check,
                                color: AppConstants.whiteColor),
                            borderColor: AppConstants.borderLineColor,
                            backGroundColor: AppConstants.greenColor,
                          ),
                          title: Text("Medication",
                              style: TextStyle(
                                color: AppConstants.whiteColor.withOpacity(0.5),
                                fontSize: 14,
                              )),
                        ),
                        ListTile(
                          leading: OutLinedButtonWidget(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.transparent,
                            ),
                            borderColor: AppConstants.borderLineColor,
                            backGroundColor:
                                AppConstants.whiteColor.withOpacity(0.1),
                          ),
                          title: Text("Diagnostic Report",
                              style: TextStyle(
                                color: AppConstants.whiteColor.withOpacity(0.5),
                                fontSize: 14,
                              )),
                        ),
                      ],
                    ),
                    // Your fixed Footer here,
                  )),
            ),

            // Your fixed Footer here,
            Container(
              margin: const EdgeInsets.only(
                  left: 16.0, top: 64, right: 16, bottom: 64.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        children: [
                          visible == false
                              ? DefaultButton(
                                  text: "Get Started",
                                  backGroundColor:
                                      AppConstants.whiteColor.withOpacity(0.9),
                                  textColor: AppConstants.blackColor,
                                  press: () {
                                    loadProgress();

                                    String ghanaCardCode = widget.authModel
                                        .getGhanaCardCode()
                                        .toString();
                                    String sixSerialsCode = widget.authModel
                                        .getGhanaSerialSixCode()
                                        .toString();
                                    String threeSerialsCode = widget.authModel
                                        .getGhanaSerialThreeCode()
                                        .toString();
                                    map = {
                                      "user": {
                                        "country_code": widget.authModel
                                            .getCountryCode()
                                            .toString(),
                                        "date_of_birth": {
                                          "day": widget.authModel
                                              .getDobModel()!
                                              .getDay()
                                              .toString(),
                                          "month": widget.authModel
                                              .getDobModel()!
                                              .getMonth()
                                              .toString(),
                                          "year": widget.authModel
                                              .getDobModel()!
                                              .getYear()
                                              .toString()
                                        },
                                        "gender": widget.authModel.getGender(),
                                        "ghana_card_number":
                                            '$ghanaCardCode-$sixSerialsCode-$threeSerialsCode',
                                        "name": widget.authModel
                                            .getFullName()
                                            .toString(),
                                        "phone": widget.authModel
                                            .getPhone()
                                            .toString(),
                                        "pin": widget.authModel.getPin()
                                      }
                                    };

                                    apiCall = APIRepository(
                                            baseUrl: APIConstants.apiBaseUrl)
                                        .apiParam(
                                            map,
                                            '',
                                            APIConstants.prePendUrl +
                                                APIConstants.patient +
                                                APIConstants.registration,
                                            "POST",
                                            context);

                                    apiCall.then((value) {
                                      var responseJson =
                                          json.decode(jsonEncode(value));

                                      loadProgress();

                                      int statusCode = 0;

                                      if (responseJson['success'] != null) {
                                        statusCode = responseJson['success'];
                                      }

                                      if (statusCode == 1) {
                                        Helper.navigateToNextPage(
                                            context, const OptionScreen());
                                      } else {
                                        var response = responseJson['errors'];

                                        responseErrorListItem
                                            .clear(); // clear list
                                        if (response['phone'] != null) {
                                          String phone =
                                              response['phone'].toString();
                                          responseErrorListItem.add(phone);
                                        }
                                        if (response['ghana_card_number'] !=
                                            null) {
                                          String ghCard =
                                              response['ghana_card_number']
                                                  .toString();
                                          responseErrorListItem.add(ghCard);
                                        }

                                        CustomAlertDialog(
                                            context: context,
                                            alertTitle: 'Alert Info',
                                            alertContent: responseErrorListItem
                                                .toString()
                                                .replaceAll(
                                                    RegExp(r'[^\w\s]+'), ''),
                                            buttonText: 'Ok',
                                            buttonAction: () => Navigator.pop(
                                                context)).createDialog();
                                      }
                                    }).whenComplete(() => {visible = false});
                                  })
                              : const LoadingView(),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                      // Your fixed Footer here,
                    ],
                  )),
            )
          ],
        )));
  }
}
