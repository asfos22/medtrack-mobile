import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/models/auth/dob_model.dart';
import 'package:medtrack/dashboard/screens/auth/registration/register_ghana_card_screen.dart';
import 'package:medtrack/repository/utils/country_picker.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/drop_down.dart';
import 'package:medtrack/widgets/form_error.dart';
import 'package:medtrack/widgets/text_input.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
  late String selectedGender = 'Select Gender', selectedMonth = 'Month';

  late Future<dynamic> apiCall;

  bool visible = false;

  AuthModel authModel = AuthModel();
  DoBModel doBModel = DoBModel();

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
      authModel.setCountryCode = dialCode;
    });
  }

  String selected = 'Month';

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Full name",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal)),

                fullNameTextInputField(),

                const Text("Phone number",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal)),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
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
                ),

                const SizedBox(height: 16),
                const Text("Gender",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal)),
                // passwordTextInputField(),
                const SizedBox(height: 16),
                DropDown(
                  fbKey: _formKey,
                  labelText: selectedGender,
                  itemsList: AppConstants.genderList,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value.value;
                      authModel.setGender = value.value;
                    });
                  },
                ),

                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Date of birth",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal)),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: DropDown(
                              fbKey: _formKey, // _bfKey,
                              labelText: selectedMonth,
                              itemsList: AppConstants().monthList,
                              onChanged: (value) {
                                setState(() {

                                  selectedMonth = value.value.toString();
                                  doBModel.setMonth = value.id.toString();
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 3,
                            child: dayTextInputField(),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 4,
                            child: yearTextInputField(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FormError(errors: errors),
                const SizedBox(height: 16),
                DefaultButton(
                  text: "NEXT",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      //-- set model [DoB]
                      authModel.setDobModel = doBModel;

                      Helper.navigateToNextPage(context,
                          RegisterGhanaCardScreen(authModel: authModel));
                    }
                  },
                )
              ],
            ),
          ],
        ));
  }

  TextInputField phoneNumberTextInputField() {
    return TextInputField(
      label: "",
      keyboardType: TextInputType.phone,
      obscure: false,
      onSaved: (newValue) => authModel.setPhone = newValue,
      //phone = newValue!,
      onChanged: (value) {
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

  //--

  TextInputField fullNameTextInputField() {
    return TextInputField(
      label: "First name & last name",
      obscure: false,
      onSaved: (newValue) => authModel.setFullName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kNameNullError);
        } else if (value.length < 2) {
          removeError(error: AppConstants.kNameNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kNameNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: AppConstants.kNameNullError);
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  TextInputField dayTextInputField() {
    return TextInputField(
      label: "Day",
      obscure: false,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => doBModel.setDay = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kDayNullError);
          return;
        }
        if (int.parse(value) <= 31) {
          removeError(error: AppConstants.kDayNullError);
          return;
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kDayNullError);
          return "";
        } else if (int.parse(value) > 31) {
          addError(error: AppConstants.kDayNullError);
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  //--

  TextInputField yearTextInputField() {
    return TextInputField(
      label: "Year",
      obscure: false,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => doBModel.setYear = newValue.toString(),
      onChanged: (value) {

        if (value.isNotEmpty) {
          removeError(error: AppConstants.kYearNullError);
          return;
        }
        if (int.parse(value) <= 2021) {
          removeError(error: AppConstants.kYearNullError);
          return;
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kYearNullError);
          return "";
        } else if (int.parse(value) > 2021) {
          addError(error: AppConstants.kYearNullError);
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }
}
