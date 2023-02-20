import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/models/auth/dob_model.dart';
import 'package:medtrack/dashboard/models/item.dart';
import 'package:medtrack/dashboard/screens/auth/registration/register_ghana_card_screen.dart';
import 'package:medtrack/repository/utils/country_picker.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/drop_down.dart';
import 'package:medtrack/widgets/text_input.dart';
import 'package:medtrack/widgets/text_label_widget.dart';

class AccountUpdateForm extends StatefulWidget {
  final AuthModel authModel;

  const AccountUpdateForm({Key? key, required this.authModel})
      : super(key: key);

  @override
  _AccountUpdateFormState createState() => _AccountUpdateFormState();
}

class _AccountUpdateFormState extends State<AccountUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String phone;
  late String fullName;
  late String phoneDialCode;
  bool remember = false;
  List<dynamic> listItem = [];
  List<dynamic> responseErrorListItem = [];
  final List<String> errors = [];
  Map map = {};
  late String? dob = '';
  late String? dobMonth = 'Month';
  late String dobDay = "Day";
  late String dobYear = "Year";
  late String selectedGender;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();

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

  final bool _obscureText = true;

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
    emailTextEditingController.text = authModel.getEmail()!.toString();
    fullNameTextEditingController.text = authModel.getFullName().toString();
    phoneNumberTextEditingController.text = authModel.getPhone().toString();

    selectedGender =
        authModel.getGender() ?? AppConstants.genderList[0].value.toString();

    if (doBModel.getDoB() != null) {
      dob = doBModel.getDoB().toString();
      dobMonth = DateFormat('MMMM').format(DateTime.parse(dob.toString()));
      dobDay = DateFormat('d').format(DateTime.parse(dob.toString()));
      dobYear = DateFormat('y').format(DateTime.parse(dob.toString()));
    }

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

                const TextLabel(text: "Email"),

                emailTextInputField(),

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
                    //print(value.value);
                    //value.value!;
                    setState(() {
                      selectedGender = value.value;
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
                            flex: 5,
                            child: DropDown(
                              fbKey: _formKey, // _bfKey,
                              labelText: dobMonth,
                              itemsList: AppConstants().monthList,
                              onChanged: (value) {
                                setState(() {
                                  dobMonth = value.value;
                                });
                                // print(value.value);
                              },
                            ), //dOBMonthTextInputField(),
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
                const SizedBox(height: 16),
                DefaultButton(
                  text: "Save",
                  press: () {
                    Helper.navigateToNextPage(
                        context, RegisterGhanaCardScreen(authModel: authModel));
                  },
                )
              ],
            ),
          ],
        ));
  }

  TextInputField phoneNumberTextInputField() {
    return TextInputField(
      controller: phoneNumberTextEditingController,
      label: "",
      keyboardType: TextInputType.phone,
      obscure: false,
      onSaved: (newValue) => phone = newValue!,
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

  TextInputField emailTextInputField() {
    return TextInputField(
      controller: emailTextEditingController,
      label: "Enter your email address",
      keyboardType: TextInputType.emailAddress,
      obscure: false,
      onSaved: (newValue) => phone = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
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
      controller: fullNameTextEditingController,
      label: "First name & last name",
      obscure: false,
      onSaved: (newValue) => fullName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPassNullError);
        } else if (value.length > 8) {
          removeError(error: AppConstants.kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: AppConstants.kShortPassError);
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }

  //-- dob
  dOBMonthTextInputField() {
    return Container(
        height: 55,
        decoration: BoxDecoration(
          color: AppConstants.textEditBackground,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Center(
          child: DropdownButton<Item>(
            icon: const Icon(
              Icons.arrow_drop_down_sharp,
            ),
            iconSize: 22,
            elevation: 16,
            style: const TextStyle(color: Colors.grey),
            isDense: true,
            hint: Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 30),
              child: Text(AppConstants().selected),
            ),
            onChanged: (value) {
              setState(() {
                AppConstants().selected = value!.value!;
              });
            },
            items: AppConstants().monthList.map((Item item) {
              return DropdownMenuItem<Item>(
                value: item,
                child: Text(item.value!),
              );
            }).toList(),
          ),
        ));
  }

  TextInputField dayTextInputField() {
    return TextInputField(
      label: dobDay,
      obscure: false,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => {},
      onChanged: (value) {
        if (value.isNotEmpty) {
        } else if (value.length > 1) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.isNotEmpty) {
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
      label: dobYear,
      obscure: false,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => {},
      onChanged: (value) {
        if (value.isNotEmpty) {
        } else if (value.length > 1) {}
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (value.isNotEmpty) {
          return "";
        }
        return null;
      },
      onTap: () {},
    );
  }
}
