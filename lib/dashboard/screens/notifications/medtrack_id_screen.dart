import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/core/settings/notifications/meditract_id_form.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/widgets/custom_settings_default_app_bar.dart';

class MedTrackIDScreen extends StatefulWidget {
  final AuthModel authModel;

  const MedTrackIDScreen({Key? key, required this.authModel}) : super(key: key);

  @override
  _MedTrackIDState createState() => _MedTrackIDState();
}

class _MedTrackIDState extends State<MedTrackIDScreen> {
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.all(0.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [MedTrackIDForm(authModel: widget.authModel)],
              ),
            ),
          ),
        ));
  }
}
