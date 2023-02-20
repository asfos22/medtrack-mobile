import 'package:flutter/material.dart';

import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/list_tile_default_widget.dart';

class MedTrackIDUpdateForm extends StatefulWidget {
  const MedTrackIDUpdateForm({Key? key}) : super(key: key);

  @override
  _MedTrackIDUpdateFormState createState() => _MedTrackIDUpdateFormState();
}

class _MedTrackIDUpdateFormState extends State<MedTrackIDUpdateForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTileDefaultWidget(
                title: "MedTrack ID",
                subTitle: Text("Connect your Ghana Card",
                    style: AppConstants.subLabelLightTextStyle(
                        FontWeight.w500, AppConstants.subLabelColor)),
                onTab: () {
                  Helper.navigateToNextPage(
                      context, const Text("Connect your Ghana Card"));
                },
                backGroundColor: AppConstants.artBoardBackground,
              ),
            ]));
  }
}
