import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/prescriptions/prescription_model.dart';
import 'package:medtrack/repository/network/api_repository.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/empty_state_card.dart';
import 'package:medtrack/widgets/loading_view.dart';
import 'package:medtrack/widgets/prescription_card.dart';
import 'package:medtrack/widgets/schedule_card.dart';

class PrescriptionEmptyScreen extends StatefulWidget {
  final PrescriptionDatum? prescription;

  const PrescriptionEmptyScreen({Key? key, this.prescription})
      : super(key: key);

  @override
  _PrescriptionEmptyScreenState createState() =>
      _PrescriptionEmptyScreenState();
}

class _PrescriptionEmptyScreenState extends State<PrescriptionEmptyScreen> {
  List<DrugItem>? drugItem;
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

  @override
  void initState() {
    super.initState();

    if (widget.prescription!.id != null) {
      executePrescriptionCall(context, widget.prescription!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "Prescriptions",
              subTitle: Container(),
              textColor: AppConstants.whiteColor,
              backgroundColor: AppConstants.primaryColor,
            )),
        body: SafeArea(
            child: visible == false
                ? drugItem == null
                    ? SingleChildScrollView(
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          margin:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [_mainContainer()],
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: drugItem!.length,
                        itemBuilder: (context, index) {
                          return prescriptionItem(widget.prescription!);
                        })
                : const LoadingView()));
  }

  prescriptionItem(PrescriptionDatum prescription) {
    return InkWell(
      onTap: () {},
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
                  children: drugItem!
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

  Widget _mainContainer() {
    return EmptyStateCard(
      icon: Container(
        margin: const EdgeInsets.only(left: 16, top: 16, bottom: 32, right: 16),
        height: 100,
        width: 120,
        child: SvgPicture.asset(
          Helper.getAssetSVGName("iconDarkPrescriptionItem", "svg"),
          color: AppConstants.whiteColor,
        ),
      ),
      headerLabel: 'You don\'t have prescriptions yet',
      subLabel: 'Prescriptions from your clinical visits will appear here.',
      onTap: () => {},
    );
  }

  void executePrescriptionCall(BuildContext context, int id) {
    //--
    loadProgress();

    String slash = APIConstants.slash;
    String prescriptionBaseUrl = APIConstants.prescriptionEndpoint;

    apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl).apiParam({},
        '',
        '$prescriptionBaseUrl$slash$id',
        APIConstants.getRequestMethod,
        context);

    apiCall?.then((value) {
      var decodeJson = json.decode(jsonEncode(value));
      var decodeJsonData = decodeJson['data'];

      if (decodeJsonData != null) {
        drugItem = decodeJsonData['items']
            .map<DrugItem>((json) => DrugItem.fromJson(json))
            .toList();
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
