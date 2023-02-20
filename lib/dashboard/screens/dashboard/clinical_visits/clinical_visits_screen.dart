import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/clinical_visits/clinical_visits_model.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/dashboard/screens/dashboard/clinical_visits/clinical_details_empty_screen.dart';
import 'package:medtrack/repository/network/api_repository.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/list_tile_widget.dart';
import 'package:medtrack/widgets/prescription_card.dart';

import '../../../../widgets/loading_view.dart';

class ClinicalVisitScreen extends StatefulWidget {
  //final Item item;
  final List<ClinicalVisit> clinicalVisits;
  final List<VisitsDetail>? visitsDetails;

  //final List<DiagnosisReport>? diagnosisReports;

  const ClinicalVisitScreen(
      {Key? key, required this.clinicalVisits, required this.visitsDetails})
      : super(key: key);

  @override
  _ClinicalVisitScreenState createState() => _ClinicalVisitScreenState();
}

class _ClinicalVisitScreenState extends State<ClinicalVisitScreen> {
  List<ClinicalVisitsDatum> clinicalClinicalVisitsData = [];

  // List<ClinicalVisitsDatum>? clinicalClinicalVisitsData;
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
    executeClinicalVisitsCall(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "Clinical Visits",
              subTitle: Container(),
              backgroundColor: AppConstants.primaryColor,
            )),
        body: SafeArea(
            child: visible == false
                ? ListView.builder(
                    itemCount: clinicalClinicalVisitsData.length,
                    //widget.clinicalVisits.length,
                    itemBuilder: (context, index) {
                      return listItem(clinicalClinicalVisitsData[
                          index]); //widget.clinicalVisits[index]);
                    })
                : const LoadingView()));
  }

  listItem(ClinicalVisitsDatum /*ClinicalVisit*/ clinicalVisit) {
    return InkWell(
      onTap: () {
        Helper.showActionModalBottomSheet(
            context,
            false,
            PrescriptionCard(
                "Call Facility",
                'Consultation',
                'Sunday . 9am - 11am',
                AppConstants.subLabelColor,
                false,
                '',
                ''));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 24.0, right: 16.0, top: 2.0, bottom: 2.0),
              width: Helper.getScreenWidth(context),
              decoration: BoxDecoration(
                color: AppConstants.borderLineColor.withOpacity(0.5),
                border: Border.all(
                  color: AppConstants.borderLineColor,
                ),
              ),
              child: Text(
                clinicalVisit.visitDate!.year.toString(), //year!,
                style: TextStyle(
                  color: AppConstants.subLabelColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.only(left: 0, right: 8.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
              child: ListTileWidget(
                icon: SvgPicture.asset(
                    Helper.getAssetSVGName("iconDarkEncounter", "svg")),
                title: clinicalVisit.title,
                subTitle: clinicalVisit.visitDate!.day.toString() +
                    "/" +
                    clinicalVisit.visitDate!.month.toString() +
                    "/" +
                    clinicalVisit.visitDate!.year.toString(),
                onTab: () {
                  Helper.navigateToNextPage(
                      context,
                      ClinicalVisitEmptyScreen(
                        clinicalVisits: clinicalVisit,
                        visitsDetails: widget.visitsDetails!,
                      ));
                },
                backGroundColor: AppConstants.artBoardBackground,
                trailingIcon: Icons.arrow_forward_ios_outlined,
              ), /*ListView(
                shrinkWrap: true,
                primary: false,
                children:clinicalClinicalVisitsData // clinicalVisit.visits!
                    .map((item) => Column(
                          children: <Widget>[
                           Text( item.title.toString())
                          ],
                        ))
                    .toList(),
              )*/
            ),
          ],
        ),
      ),
    );
  }

  void executeClinicalVisitsCall(BuildContext context) {
    //Map map = Map();
    loadProgress();

    apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl).apiParam({},'',
        APIConstants.clinicalVisitsEndpoint,
        APIConstants.getRequestMethod,
        context);

    apiCall?.then((value) {
      // var responseJson = json.decode(jsonEncode(value));
      // int statusCode = responseJson['code'];
      //String statusMessage = responseJson['message'];

      var decodeJson = json.decode(jsonEncode(value));
      var decodeJsonData = decodeJson['data'];

      if (decodeJsonData != null) {
        setState(() {
          clinicalClinicalVisitsData = decodeJsonData
              .map<ClinicalVisitsDatum>(
                  (json) => ClinicalVisitsDatum.fromJson(json))
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
