import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // for date format
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/dashboard/models/prescriptions/prescription_model.dart';
import 'package:medtrack/dashboard/screens/empty/prescription_empty_screen.dart';
import 'package:medtrack/repository/network/api_repository.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/loading_view.dart';
import 'package:medtrack/widgets/prescription_card.dart';
import 'package:medtrack/widgets/schedule_card.dart';

class PrescriptionScreen extends StatefulWidget {
  // const PrescriptionScreen({Key? key}) : super(key: key);

  final List<Prescription>? prescription;

  const PrescriptionScreen({Key? key, required this.prescription})
      : super(key: key);

  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  List<PrescriptionDatum> prescription = [];
  Future<dynamic>? apiCall;
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

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/item_data_list.json');
    final data = await json.decode(response);

    setState(() {
      prescription = data['items'][0]['prescription']
          .map((data) => Prescription.fromJson(data))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //readJson();
    executePrescriptionCall(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppConstants.backgroundColor,
            appBar: PreferredSize(
                preferredSize: const Size(
                    double.infinity, AppConstants.defaultAppBarSizeHeight),
                child: CustomAppBar(
                  title: "Prescriptions",
                  subTitle: Container(),
                  backgroundColor: AppConstants.primaryColor,
                )),
            body: visible == false
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: prescription.length,
                    itemBuilder: (context, index) {
                      return prescriptionItem(prescription[index]);
                    })
                : const LoadingView()));
  }

  prescriptionItem(PrescriptionDatum prescription) {
    return InkWell(
      onTap: () {
       Helper.navigateToNextPage(context,  PrescriptionEmptyScreen(prescription: prescription));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppConstants.borderLineColor,
                ),
              ),
              child: ScheduleCard(
                  "Prescribed during", //prescription.title!,
                  prescription.title!, // prescription.description!,
                  prescription.insertedAt!.day.toString(), //prescription.day!,
                  DateFormat("MMM").format(
                      DateTime.parse(prescription.insertedAt!.toString())),
                  //prescription!.insertedAt!.month.toString(), //prescription.month!,
                  AppConstants.subLabelColor,
                  GestureDetector(
                    onTap: () {
                      Helper.showActionModalBottomSheet(
                          context,
                          false,
                          PrescriptionCard(
                              "Call Facility",
                              prescription.assignedPharmacy!.location!,
                              prescription.assignedPharmacy!.facilityName!,
                              AppConstants.subLabelColor,
                              true,
                              '',
                              ''));
                    },
                    child: const Icon(Icons.more_horiz),
                  )),
            ),
            Container(
                width: Helper.getScreenWidth(context),
                padding: const EdgeInsets.all(0.0),
                margin: const EdgeInsets.only(
                    left: 84, top: 16.0, bottom: 4.0, right: 16.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppConstants.borderLineColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: prescription.items!
                      .map(
                        (item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: Helper.getScreenWidth(context),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    item.drug?.name != null
                                        ? Text(item.drug?.name ?? '',
                                            style:
                                                AppConstants.h2HeadingTextStyle)
                                        : Container(),
                                    item.drug?.dosage != null
                                        ? Text(
                                            item.drug?.dosage.toString() ?? '',
                                            style: AppConstants
                                                .subLabelLightTextStyle(
                                                    FontWeight.w700,
                                                    AppConstants.subLabelColor
                                                        .withOpacity(0.7)))
                                        : Container(),
                                  ],
                                )),
                            item.drug!.description != null
                                ? Container(
                                    width: Helper.getScreenWidth(context),
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: AppConstants.lineColor
                                          .withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(item.drug?.description ?? '',
                                            //prescription.description!,
                                            style: AppConstants
                                                .subLabelLightTextStyle(
                                                    FontWeight.w700,
                                                    AppConstants.blackColor))
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      )
                      .toList(),
                ))
          ],
        ),
      ),
    );
  }

  void executePrescriptionCall(BuildContext context) {
    //--
    loadProgress();

    apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl).apiParam({},'',
        APIConstants.prescriptionEndpoint,
        APIConstants.getRequestMethod,
        context);

    apiCall?.then((value) {
      var decodeJson = json.decode(jsonEncode(value));
      var decodeJsonData = decodeJson['data'];

      if (decodeJsonData != null) {
        setState(() {
          prescription = decodeJsonData
              .map<PrescriptionDatum>(
                  (json) => PrescriptionDatum.fromJson(json))
              .toList();
        });
      } else {
        CustomAlertDialog(
            context: context,
            alertTitle: 'Alert Info',
            alertContent: "No data available",
            buttonText: 'Ok',
            buttonAction: () => Navigator.pop(context)).createDialog();
      }
    }).whenComplete(() => {loadProgress()});
  }
}
