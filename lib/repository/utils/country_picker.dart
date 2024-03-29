import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

// ignore: must_be_immutable
class CountryPicker extends StatefulWidget {
  CountryPicker({
    Key? key,
    this.callBackFunction,
    this.headerText,
    this.headerBackgroundColor,
    this.headerTextColor,
  }) : super(key: key);

  final Function? callBackFunction;
  final String? headerText;
  final Color? headerBackgroundColor;
  final Color? headerTextColor;
  bool isInit = true;

  @override
  _CountryPickerState createState() => _CountryPickerState();
}

// Country picker state class
class _CountryPickerState extends State<CountryPicker> {
  List<CountryModel>? countryList = [];
  CountryModel? selectedCountryData;

  @override
  //method calls when state change
  // ignore: avoid_void_async
  void didChangeDependencies() async {
    if (widget.isInit) {
      widget.isInit = false;
      final data = await DefaultAssetBundle.of(context)
          .loadString('assets/country_codes.json');
      setState(() {
        countryList = parseJson(data);

        if (countryList != null) {
          selectedCountryData = countryList?[0];
        }
      });
      widget.callBackFunction!(
          selectedCountryData?.name,
          selectedCountryData?.dialCode,
          selectedCountryData?.code,
          selectedCountryData?.flag);
    }
    super.didChangeDependencies();
  }

  // parse json data into model
  List<CountryModel> parseJson(String response) {
    if (response.isEmpty) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<CountryModel>(
            (json) => CountryModel.fromJson(json as Map<String, dynamic>))
        .toList() as List<CountryModel>;
  }

  //build method for UI render
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        showDialogue(context);
      },
      child: Container(
        width: 72,
        height: 55,
        padding: const EdgeInsets.only(left: 8.0),
        decoration: BoxDecoration(
            color: AppConstants.lineColor,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* Text(
              selectedCountryData?.flag ?? '',
              style: const TextStyle(fontSize: 20),
            ),*/
            Text(
              selectedCountryData?.dialCode ?? '',
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  // show country picker dialogue
  Future<void> showDialogue(BuildContext context) async {
    final countryData = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        searchList: countryList!,
        callBackFunction: widget.callBackFunction!,
        headerText: widget.headerText,
        headerBackgroundColor: widget.headerBackgroundColor,
        headerTextColor: widget.headerTextColor,
      ),
    );
    if (countryData != null) {
      selectedCountryData = countryData as CountryModel;
    }
    setState(() {});
  }
}

// Custom stateful widget dialogue

class CustomDialog extends StatefulWidget {
  const CustomDialog(
      {Key? key,
      this.searchList,
      required this.callBackFunction,
      this.headerText,
      this.headerBackgroundColor,
      this.headerTextColor})
      : super(key: key);

  final List<CountryModel>? searchList;
  final Function? callBackFunction;
  final String? headerText;
  final Color? headerBackgroundColor;
  final Color? headerTextColor;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

// dialogue state class
class _CustomDialogState extends State<CustomDialog> {
  List<CountryModel>? tmpList = [];

  // dialogue inner widget
  Widget dialogContent(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color: AppConstants.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Picker Header
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: widget.headerBackgroundColor ??
                    Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                )),
            child: Stack(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.headerText ?? 'Select Country',
                    style: TextStyle(
                        fontSize: 18,
                        color:
                            widget.headerTextColor ?? AppConstants.whiteColor),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkResponse(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, color: AppConstants.blackColor),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            height: 45,
            decoration: BoxDecoration(
              color: const Color.fromARGB(8, 0, 0, 0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: const InputDecoration(
                  hintText: 'Search Country',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18.0,
                    color: Colors.black38,
                  )),
              onChanged: filterData,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  ...tmpList!.map(
                    (item) => GestureDetector(
                      onTap: () {
                        Navigator.pop(context, item);
                        widget.callBackFunction!(
                            item.name, item.dialCode, item.flag);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.flag ?? '',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                item.name ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              item.dialCode ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // filter data on search bar text change
  void filterData(String text) {
    tmpList = [];
    if (text == '') {
      tmpList?.addAll(widget.searchList!);
    } else {
      // ignore: avoid_function_literals_in_foreach_calls
      widget.searchList?.forEach((userDetail) {
        // ignore: always_put_control_body_on_new_line
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          tmpList?.add(userDetail);
        }
      });
    }
    setState(() {});
  }

  // initiation of state
  @override
  void initState() {
    super.initState();
    tmpList = widget.searchList;
  }

  // build method
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

//country model
class CountryModel {
  const CountryModel({this.name, this.dialCode, this.code, this.flag});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final flag = CountryModel.getEmojiFlag(json['code'] as String);
    return CountryModel(
        name: json['name'] as String,
        dialCode: json['dial_code'] as String,
        code: json['code'] as String,
        flag: flag);
  }

  final String? name;
  final String? dialCode;
  final String? code;
  final String? flag;

  //Converting country code into emoji flag
  static String getEmojiFlag(String emojiString) {
    const flagOffset = 0x1F1E6;
    const asciiOffset = 0x41;

    final firstChar = emojiString.codeUnitAt(0) - asciiOffset + flagOffset;
    final secondChar = emojiString.codeUnitAt(1) - asciiOffset + flagOffset;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }
}
