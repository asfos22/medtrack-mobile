import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/models/auth/health_data_model.dart';
import 'package:medtrack/dashboard/screens/auth/registration/register_ghana_card_screen.dart';
import 'package:medtrack/dashboard/screens/dashboard/home_screen.dart';
import 'package:medtrack/repository/utils/country_picker.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/card_main.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/drop_down.dart';
import 'package:medtrack/widgets/horizontal_line.dart';
import 'package:medtrack/widgets/text_input.dart';
import 'package:medtrack/widgets/text_label_widget.dart';

import '../../constants/api_constants.dart';
import '../../repository/network/api_repository.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/loading_view.dart';

class HealthDataForm extends StatefulWidget {
  const HealthDataForm({Key? key, required this.authModel}) : super(key: key);
  final AuthModel authModel;

  @override
  _HealthDataFormState createState() => _HealthDataFormState();
}

class _HealthDataFormState extends State<HealthDataForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String phone;
  late String password;
  late String phoneDialCode;
  bool remember = false;
  List<dynamic> listItem = [];
  List<dynamic> responseErrorListItem = [];
  final List<String> errors = [];
  Map map = {};
  HealthDataModel healthDataModel = HealthDataModel();
  late Future<dynamic> apiCall;

  bool visible = false;

  String? bloodGroup;

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

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  late FToast fToast;

  void _callBackFunction(
      String? name, String dialCode, String code, String? flag) {
    setState(() {
      // phone dia code
      phoneDialCode = dialCode;
      //print(name! + " " + dialCode + " " + flag!);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  margin: const EdgeInsets.only(
                      left: 16.0, bottom: 16.0, right: 16.0),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CardMain(
                            title: "Keep updated",
                            description:
                                "Update your health information in the event of emergency service response.",
                            color: AppConstants.subLabelColor.withOpacity(0.1)),
                        const SizedBox(height: 16.0),
                        const TextLabel(text: "Blood Group"),
                        DropDown(
                          fbKey: _formKey,
                          labelText: bloodGroup ?? 'Select one',
                          itemsList: AppConstants.bloodGroupList,
                          onChanged: (value) {
                            //print("SELECTED");
                            //print(value.value);
                            //value.value!;
                            setState(() {
                              bloodGroup = value.value;
                              healthDataModel.setBloodGroup = value.value;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        const TextLabel(text: "Allergies"),
                        allergiesTextInputField(),
                        const TextLabel(text: "Known / Pre-Existing Condition"),
                        knownExistingConditionsTextInputField(),
                        const SizedBox(height: 8.0),
                        const TextLabel(text: "Current Medications"),
                        currentMedicationTextInputField(),
                        const SizedBox(height: 16.0),
                        const TextLabel(text: "Height & Weight"),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: heightTextInputField(),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 5,
                              child: weightTextInputField(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const TextLabel(text: "Blood pressure"),
                        bloodPressureTextInputField(),
                        const SizedBox(height: 16),
                        const TextLabel(text: "Phone number"),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CountryPicker(
                                callBackFunction: _callBackFunction,
                                headerText: 'Select Country',
                                headerBackgroundColor: AppConstants.whiteColor,
                                headerTextColor: AppConstants.whiteColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 7,
                              child: phoneNumberTextInputField(),
                            ),
                          ],
                        ),
                      ])),
              const HorizontalLine(height: 16),
              Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  margin: const EdgeInsets.only(
                      left: 16.0, top: 16.0, bottom: 16.0, right: 16.0),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        const TextLabel(text: "Last Hospital Visited"),
                        lastHospitalVisitedTextInputField(),
                        const SizedBox(height: 8.0),
                        const TextLabel(text: "Primary Physician (If Known)"),
                        primaryPhysicianTextInputField(),
                        const TextLabel(text: "Phone number (If Available)"),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: CountryPicker(
                                  callBackFunction: _callBackFunction,
                                  headerText: 'Select Country',
                                  headerBackgroundColor:
                                      AppConstants.whiteColor,
                                  headerTextColor: AppConstants.whiteColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                  flex: 7, child: fPhoneNumberTextInputField()),
                            ],
                          ),
                        ),
                      ])),
              Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                margin:
                    const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                width: double.infinity,
                child: visible == false
                    ? DefaultButton(
                        text: "Save Changes",
                        press: () {
                          loadProgress();

                          String ghanaCardCode =
                              widget.authModel.getGhanaCardCode().toString();
                          String sixSerialsCode = widget.authModel
                              .getGhanaSerialSixCode()
                              .toString();
                          String threeSerialsCode = widget.authModel
                              .getGhanaSerialThreeCode()
                              .toString();
                          map = {
                            "data": {
                              "allergies": healthDataModel.getAllergies(),
                              "blood_type": healthDataModel.getBloodGroup(),
                              "blood_pressure":
                                  healthDataModel.getBloodPressure(),
                              "height": healthDataModel.getHeight(),
                              "weight": healthDataModel.getWeight(),
                              "facility_name":
                                  healthDataModel.getFacilityName(),
                              "facility_contact":
                                  healthDataModel.getFacilityPhone(),
                              "physician_name":
                                  healthDataModel.getPhysicianName(),
                              "physician_contact": healthDataModel.getPPhone(),
                              "current_medication":
                                  healthDataModel.getCurrentMedication(),
                              "known_pre_existing_condition":
                                  healthDataModel.getKnownPreExistingCondition()
                            }
                          };

                          apiCall =
                              APIRepository(baseUrl: APIConstants.apiBaseUrl)
                                  .apiParam(
                                      map,
                                      '',
                                      APIConstants.healthDataEndpoint,
                                      APIConstants.postRequestMethod,
                                      context);

                          apiCall.then((value) {
                            var responseJson = json.decode(jsonEncode(value));

                            loadProgress();

                            int statusCode = 0;

                            if (responseJson['data']['status'] == 1) {
                              statusCode = responseJson['data']['status'];

                              // if (statusCode == 1) {
                              //Helper.navigateToNextPage(
                              //   context, const HomeScreen());

                              CustomAlertDialog(
                                  context: context,
                                  alertTitle: 'Alert info',
                                  alertContent: "Heath data submitted",
                                  buttonText: 'Ok',
                                  buttonAction: () =>
                                      Navigator.pop(context)).createDialog();
                            } else {
                              var response = responseJson['error'];

                              responseErrorListItem.clear(); // clear list

                              responseErrorListItem.add(response.toString());

                              CustomAlertDialog(
                                  context: context,
                                  alertTitle: 'Alert Info',
                                  alertContent: responseErrorListItem
                                      .toString()
                                      .replaceAll(RegExp(r'[^\w\s]+'), ''),
                                  buttonText: 'Ok',
                                  buttonAction: () =>
                                      Navigator.pop(context)).createDialog();
                            }
                          }).whenComplete(() => {visible = false});
                        })
                    : const LoadingView(),
                /*DefaultButton(
                    text: "Save Changes",
                    press: () {
                      // Helper.navigateToNextPage(context,
                      //     RegisterGhanaCardScreen(authModel: widget.authModel));
                      print("SAVE CHANGES");
                      print(healthDataModel.getBloodGroup());
                      print(healthDataModel.getAllergies());
                      print(healthDataModel.getKnownPreExistingCondition());
                      print(healthDataModel.getPPhone());
                      print(healthDataModel.getFacilityPhone());
                      print(healthDataModel.getFacilityName());
                      print(healthDataModel.getPhysicianName());
                      print(healthDataModel.getPhysicianName());
                      print(healthDataModel.getHeight());
                      print(healthDataModel.getWeight());
                      print(healthDataModel.getCurrentMedication());
                    },
                  )*/
              ),
            ],
          ),
        ));
  }

  TextInputField phoneNumberTextInputField() {
    return TextInputField(
      label: "",
      keyboardType: TextInputType.phone,
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setPPhone = value;
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  TextInputField fPhoneNumberTextInputField() {
    return TextInputField(
      label: "",
      keyboardType: TextInputType.phone,
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setFacilityPhone = value;
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  //-- allergies

  TextInputField allergiesTextInputField() {
    return TextInputField(
      label: "Separate allergies with a comma",
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setAllergies = value;

        if (value.isNotEmpty) {
        } else if (value.length > 8) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.length < 8) {
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  //-- known and existing condition

  TextInputField knownExistingConditionsTextInputField() {
    return TextInputField(
      label: "",
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setKnownPreExistingCondition = value;

        if (value.isNotEmpty) {
        } else if (value.length > 8) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.length < 8) {
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  //-- current Medication

  TextInputField currentMedicationTextInputField() {
    return TextInputField(
      label: "",
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setCurrentMedication = value;

        if (value.isNotEmpty) {
        } else if (value.length > 8) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.length < 8) {
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  //-- height

  TextInputField heightTextInputField() {
    return TextInputField(
      label: "",
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setHeight = value;
        if (value.isNotEmpty) {
        } else if (value.length > 8) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.length < 8) {
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

//weight
  TextInputField weightTextInputField() {
    return TextInputField(
      label: "",
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setWeight = value;
        if (value.isNotEmpty) {
        } else if (value.length > 8) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.length < 8) {
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  //-- blood pressure

  TextInputField bloodPressureTextInputField() {
    return TextInputField(
      label: "",
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setBloodPressure = value;
        if (value.isNotEmpty) {
        } else if (value.length > 8) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.length < 8) {
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  TextInputField lastHospitalVisitedTextInputField() {
    return TextInputField(
      label: "Enter facility name",
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setFacilityName = value;
        if (value.isNotEmpty) {
        } else if (value.length > 8) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.length < 8) {
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  TextInputField primaryPhysicianTextInputField() {
    return TextInputField(
      label: "Enter physician's name",
      obscure: false,
      onSaved: (newValue) => '',
      onChanged: (value) {
        healthDataModel.setPhysicianName = value;
        if (value.isNotEmpty) {
        } else if (value.length > 8) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.length < 8) {
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }
}
