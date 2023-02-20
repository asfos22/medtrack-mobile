import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/screens/auth/registration/register_update_screen.dart';
import 'package:medtrack/dashboard/screens/notifications/medtrack_id_update_screen.dart';
import 'package:medtrack/dashboard/screens/notifications/notification_settings_screen.dart';
import 'package:medtrack/dashboard/screens/notifications/residency_screen.dart';
import 'package:medtrack/dashboard/screens/pin_code/pin_code_update_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/list_tile_widget.dart';

class SettingsUpdateForm extends StatefulWidget {
  const SettingsUpdateForm({Key? key, required this.authModel})
      : super(key: key);
  final AuthModel authModel;

  @override
  _SettingsUpdateFormState createState() => _SettingsUpdateFormState();
}

class _SettingsUpdateFormState extends State<SettingsUpdateForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                    leading: Stack(children: <Widget>[
                      CircleAvatar(
                        radius: 30.0,
                        child: SvgPicture.asset(
                            Helper.getAssetSVGName("iconDarkId", "svg")),
                        backgroundColor: AppConstants.artBoardBackground,
                      ),
                      Positioned(
                          top: -1,
                          right: 5,
                          child: Stack(
                            children: <Widget>[
                              Icon(
                                Icons.brightness_1,
                                size: 12.0,
                                color: AppConstants.colorRed,
                              ),
                            ],
                          ))
                    ]),
                    title: Text("MedTrack ID",
                        style: AppConstants.h2HeadingTextStyle),
                    subtitle: Text("Connect your Ghana Card",
                        style: AppConstants.subLabelLightTextStyle(
                            FontWeight.w500, AppConstants.subLabelColor)),
                    onTap: () {
                      Helper.navigateToNextPage(
                          context, const MedTrackIDUpdateScreen());
                    },
                    trailing:
                        const Icon(Icons.arrow_forward_ios_outlined, size: 16)),
                ListTileWidget(
                  icon: SvgPicture.asset(
                      Helper.getAssetSVGName("iconDarkPerson", "svg")),
                  title: "Personal Information",
                  subTitle: "Update your email, phone number etc",
                  onTab: () {
                    Helper.navigateToNextPage(context,
                        RegisterUpdateScreen(authModel: widget.authModel));
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
                    Helper.navigateToNextPage(context, const ResidencyScreen());
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
                          authModel: widget.authModel,
                        ));
                  },
                  backGroundColor: AppConstants.artBoardBackground,
                  trailingIcon: Icons.arrow_forward_ios_outlined,
                ),
              ]),
        ));
  }
}
