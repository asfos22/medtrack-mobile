import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/core/auth/register/register_ghana_card_update_form.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_settings_default_app_bar.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/horizontal_line.dart';
import 'package:medtrack/widgets/list_tile_default_widget.dart';

class MedTrackIDUpdateScreen extends StatefulWidget {
  const MedTrackIDUpdateScreen({Key? key}) : super(key: key);

  @override
  _MedTrackIDUpdateScreenState createState() => _MedTrackIDUpdateScreenState();
}

class _MedTrackIDUpdateScreenState extends State<MedTrackIDUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomSettingsDefaultAppBar(
              title: "MedTrack ID",
              textColor: AppConstants.blackColor,
              backgroundColor: AppConstants.borderLineColor,
              subTitle: null,
            )),
        bottomSheet: Container(
          margin: const EdgeInsets.all(16),
          child: DefaultButton(
            text: "Save Changes",
            press: () {},
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding:
                          const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                      margin: const EdgeInsets.all(0.0),
                      width: double.infinity,
                      child: Text("Temporary ID",
                          style: AppConstants.h2HeadingLightTextStyle)),
                  Container(
                      width: Helper.getScreenWidth(context) / 3,
                      height: 45,
                      margin: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: AppConstants.greenColor.withOpacity(0.1),
                        border: Border.all(
                            color: AppConstants.greyColor.withOpacity(0.5),
                            // Set border color
                            width: 1.0), // Set border width
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Center(
                        child: Text(
                          'GHA 236497 01',
                          style: TextStyle(
                              color: AppConstants.greenColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: const HorizontalLine(height: 1)),
                  ListTileDefaultWidget(
                    title: "Connected",
                    subTitle: Text(
                        'Your MedTrack ID allows physicians to search and add you to their service',
                        style: AppConstants.subLabelLightTextStyle(
                            FontWeight.w500, AppConstants.subLabelColor)),
                    onTab: () {},
                    backGroundColor: AppConstants.artBoardBackground,
                  ),
                  Container(
                      padding: const EdgeInsets.all(0.0),
                      margin: const EdgeInsets.all(16.0),
                      width: double.infinity,
                      child: const RegisterGhanaCardUpdateForm()),
                  const HorizontalLine(height: 1)
                ]),
          ),
        ));
  }
}
