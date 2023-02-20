import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/screens/auth/login/login_screen.dart';
import 'package:medtrack/dashboard/screens/auth/registration/register_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/default_button.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.primaryColor,
        body: SafeArea(
            child: Stack(children: <Widget>[
          Container(
              margin:
                  const EdgeInsets.only(left: 16.0, right: 16, bottom: 64.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        children: [
                          SvgPicture.asset(Helper.getAssetSVGName(
                              "medTrackLogoIcon", "svg")),
                          const SizedBox(
                            height: 24,
                          ),
                          Text("MedTrack",
                              style: TextStyle(
                                  color: AppConstants.whiteColor,
                                  fontFamily: 'Roboto',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 16,
                          ),
                          Text("Health record for All",
                              style: TextStyle(
                                  color:
                                      AppConstants.whiteColor.withOpacity(0.5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                      // Your fixed Footer here,
                    ],
                  ))),
          Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 64.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  children: <Widget>[
                    Column(
                      children: [
                        DefaultButton(
                          text: "Register",
                          backGroundColor:
                              AppConstants.whiteColor.withOpacity(0.9),
                          textColor: AppConstants.blackColor,
                          press: () {
                            Helper.navigateToNextPage(
                                context, const RegisterScreen());
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DefaultButton(
                          text: "Sign In",
                          backGroundColor:
                              AppConstants.blackColor.withOpacity(0.5),
                          textColor: AppConstants.whiteColor,
                          press: () {
                            Helper.navigateToNextPage(
                                context, const LoginScreen());
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
}
