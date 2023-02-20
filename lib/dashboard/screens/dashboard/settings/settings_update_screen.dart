import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/core/settings/settings_update_form.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/widgets/chip_widget.dart';
import 'package:medtrack/widgets/custom_settings_app_bar.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import '../../../../constants/api_constants.dart';
import '../../../../repository/network/api_exceptions.dart';
import '../../../../repository/network/api_repository.dart';
import '../../../../widgets/custom_alert_dialog.dart';
import '../../../../widgets/loading_view.dart';

class SettingsUpdateScreen extends StatefulWidget {
  const SettingsUpdateScreen({Key? key}) : super(key: key);

  @override
  _SettingsUpdateScreenState createState() => _SettingsUpdateScreenState();
}

class _SettingsUpdateScreenState extends State<SettingsUpdateScreen> {
  AuthModel authModel = AuthModel();

  String imagePath = '';
  late Future<dynamic> apiCall;
  Map map = {};

  bool visible = false;

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

  TextButton bottomSheetButton(
      {required VoidCallback onPressed, required String title}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }

  void pickImageFromBrowser() async {
    ImagePicker pick = ImagePicker();
    final image = await pick.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image!.path;
    });
  }

  void pickImageFromCamera() async {
    ImagePicker pick = ImagePicker();
    final image = await pick.pickImage(source: ImageSource.camera);
    setState(() {
      imagePath = image!.path;
    });
  }

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
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: 125,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  bottomSheetButton(
                                    title: "Camera",
                                    onPressed: pickImageFromCamera,
                                  ),
                                  bottomSheetButton(
                                    title: "Gallery",
                                    onPressed: pickImageFromBrowser,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                      margin: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: imagePath.isNotEmpty
                          ? CircleAvatar(
                              radius: 32.0,
                              backgroundColor: AppConstants.whiteColor,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.file(
                                      File(
                                        imagePath,
                                      ),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            )
                          : CircleAvatar(
                              radius: 32.0,
                              backgroundImage: const NetworkImage(
                                  'https://via.placeholder.com/150'),
                              backgroundColor: AppConstants.backgroundColor,
                            )),
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
                    visible == false
                        ? ChipWidget(
                            //listTag: diagnosis.investigations!.tags,
                            tags: <TagWidget>[
                              TagWidget(AppConstants.update,
                                  AppConstants.primaryColor),
                            ],
                            selected: (bool value) {
                              map = {"picture": imagePath};
                              apiCall = APIRepository(
                                      baseUrl: APIConstants.apiBaseUrl)
                                  .apiParam(
                                      map,
                                      imagePath,
                                      APIConstants.prePendUrl +
                                          APIConstants.patient +
                                          APIConstants.slash +
                                          APIConstants.profilePicture,
                                      APIConstants.multipartRequest,
                                      context);

                              apiCall.then((value) {
                               // loadProgress();
                                var responseJson =
                                    json.decode(jsonEncode(value));
                                print("UPLOAD");

                               /* var errorResponse = responseJson['error'];
                                var successResponse = responseJson['success'];

                                if (successResponse == 1) {
                                } else if (errorResponse != null) {
                                  CustomAlertDialog(
                                          context: context,
                                          alertTitle: 'Alert Info',
                                          alertContent:
                                              "".toString().replaceAll(
                                                  RegExp(r'[^\w\s]+'), ''),
                                          buttonText: 'Ok',
                                          buttonAction: () =>
                                              Navigator.pop(context))
                                      .createDialog();
                                }*/
                              }).whenComplete(() => { visible = false});
                            },
                          )
                        : const LoadingView(),
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
            children: [SettingsUpdateForm(authModel: authModel)],
          ),
        ),
      ),
    ));
  }

//todo remove the async

}
