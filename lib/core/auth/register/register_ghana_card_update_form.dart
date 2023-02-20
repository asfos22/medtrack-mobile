import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/widgets/text_input.dart';

class RegisterGhanaCardUpdateForm extends StatefulWidget {
  const RegisterGhanaCardUpdateForm({Key? key}) : super(key: key);

  @override
  _RegisterGhanaCardUpdateFormState createState() =>
      _RegisterGhanaCardUpdateFormState();
}

class _RegisterGhanaCardUpdateFormState
    extends State<RegisterGhanaCardUpdateForm> {
  final _formKey = GlobalKey<FormState>();

  bool remember = false;
  List<dynamic> listItem = [];
  List<dynamic> responseErrorListItem = [];
  final List<String> errors = [];
  Map map = {};

  late Future<dynamic> apiCall;

  bool visible = false;

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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          color: AppConstants.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Connect your Ghana Card",
                          style: AppConstants.subLabelLightTextStyle(
                              FontWeight.w700, AppConstants.blackColor)),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: countryCodeTextInputField(),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 4,
                            child: sixCodeTextInputField(),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 3,
                            child: threeCodeTextInputField(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  TextInputField countryCodeTextInputField() {
    return TextInputField(
      label: "GHA",
      keyboardType: TextInputType.text,
      obscure: false,
      onSaved: (newValue) => {},
      onChanged: (value) {
        if (value.isNotEmpty) {}
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

  TextInputField sixCodeTextInputField() {
    return TextInputField(
      label: "000",
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

  TextInputField threeCodeTextInputField() {
    return TextInputField(
      label: "000",
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
