import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/horizontal_line.dart';
import 'package:medtrack/widgets/list_tile_default_widget.dart';

class MedTrackIDForm extends StatefulWidget {
  final AuthModel authModel;

  const MedTrackIDForm({Key? key, required this.authModel}) : super(key: key);

  @override
  _MedTrackIDFormState createState() => _MedTrackIDFormState();
}

class _MedTrackIDFormState extends State<MedTrackIDForm> {
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
          margin: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTileDefaultWidget(
                  title: "Connected",
                  subTitle: Text("Your MedTrack ID allows physicians to search and add you to their service",
                      style: AppConstants.subLabelLightTextStyle(
                          FontWeight.w500, AppConstants.subLabelColor)),

                  onTab: () {},
                  backGroundColor: AppConstants.artBoardBackground,
                ),
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
                        widget.authModel.getGhanaCardNumber() != null ? widget
                            .authModel.getGhanaCardNumber().toString(): '',
                        style: TextStyle(
                            color: AppConstants.greenColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                const HorizontalLine(height: 1)
              ]),
        ));
  }
}
