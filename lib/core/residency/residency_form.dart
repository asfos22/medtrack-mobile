import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item.dart';
import 'package:medtrack/widgets/drop_down.dart';
import 'package:medtrack/widgets/text_input.dart';
import 'package:medtrack/widgets/text_label_widget.dart';

class ResidencyForm extends StatefulWidget {
  const ResidencyForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<ResidencyForm> {
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

  List<Item> genderList = <Item>[
    Item(id: "1", value: 'MALE'),
    Item(id: "2", value: "FEMALE")
  ];

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
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Region",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal)),
                const SizedBox(height: 16),
                DropDown(
                  fbKey: _formKey,
                  labelText: 'Select Region',
                  itemsList: AppConstants.regionsList,
                  onChanged: (value) {
                    // print("SELECTED");
                    // print(value.value);
                  },
                ),
                const SizedBox(height: 16.0),
                const Text("City",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal)),
                const SizedBox(height: 8.0),
                DropDown(
                  fbKey: _formKey,
                  labelText: 'Select City',
                  itemsList: AppConstants.cityList,
                  onChanged: (value) {
                    // value.value!;
                  },
                ),
                const SizedBox(height: 16.0),
                const TextLabel(text: "Address"),
                addressInputField()
              ],
            ),
          ],
        ));
  }

  //--

  TextInputField addressInputField() {
    return TextInputField(
      label: "Enter your home address",
      obscure: false,
      isMulti: true,
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
