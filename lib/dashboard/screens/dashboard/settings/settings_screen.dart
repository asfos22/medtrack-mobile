import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/core/settings/settings_form.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/screens/dashboard/settings/settings_update_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/chip_widget.dart';
import 'package:medtrack/widgets/custom_settings_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthModel authModel = AuthModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size(
              double.infinity, AppConstants.settingsAppBarSizeHeight),
          child: CustomSettingsAppBar(
            title: "Settings",
            subTitle: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8.0, right: 8.0),
                  child: CircleAvatar(
                    radius: 32.0,
                    backgroundImage:
                        const NetworkImage('https://via.placeholder.com/150'),
                    backgroundColor: AppConstants.backgroundColor,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: Text(
                        AppConstants.profilePhoto,
                        style: TextStyle(
                          color: AppConstants.subLabelColor.withOpacity(0.5),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ChipWidget(
                      //listTag: diagnosis.investigations!.tags,
                      tags: <TagWidget>[
                        TagWidget(
                            AppConstants.update, AppConstants.primaryColor),
                      ],
                      selected: (bool value) {
                        Helper.navigateToNextPage(
                            context, const SettingsUpdateScreen());
                      },
                    )
                  ],
                )
              ],
            ),
            textColor: AppConstants.blackColor,
            backgroundColor: AppConstants.borderLineColor,
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [SettingsForm(authModel: authModel)],
          ),
        ),
      ),
    ));
  }
}
