import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/clinical_visits/clinical_visits_model.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/clinical_list_tile_widget.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/doc_section.dart';
import 'package:medtrack/widgets/dragging_handle.dart';
import 'package:medtrack/widgets/horizontal_line.dart';

import '../../../../constants/api_constants.dart';
import '../../../../repository/network/api_repository.dart';
import '../../../../widgets/custom_alert_dialog.dart';
import '../../../models/clinical_visits/visit_encounter_model.dart';
import '../encounter_actions/diagnosis_details_screen.dart';
import '../encounter_actions/encounter_examinations_screen.dart';
import '../prescriptions_list/prescription_screen.dart';
import 'clinical_access_control_screen.dart';

class ClinicalVisitEmptyScreen extends StatefulWidget {
  // visits
  final ClinicalVisitsDatum clinicalVisits;
  final List<VisitsDetail>? visitsDetails;

  const ClinicalVisitEmptyScreen(
      {Key? key, required this.clinicalVisits, required this.visitsDetails})
      : super(key: key);

  @override
  _ClinicalVisitEmptyScreenState createState() =>
      _ClinicalVisitEmptyScreenState();
}

class _ClinicalVisitEmptyScreenState extends State<ClinicalVisitEmptyScreen> {
  late VisitEncounterData visitEncounterData;
  List<VisitAttachment> visitAttachmentData = [];
  List<DiagnosisItem> visitDiagnosisData = [];

  dynamic visitEncounterModel;

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
    // TODO: implement initState
    print("CLINICAL VISITS");
    print(widget.clinicalVisits.id);

    executeClinicalVisitsDetailsCall(
        context, int.parse(widget.clinicalVisits.id.toString()));

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
              title: "Visits Details",
              subTitle: Container(),
              backgroundColor: AppConstants.primaryColor,
            )),
        bottomSheet: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          height: 64,
          child: const DraggingHandle(),
        ),
        body: SafeArea(
            child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  visitEncounterModel!=null? DocSection(
                    icon: SvgPicture.asset(
                        Helper.getAssetSVGName("iconDarkPerson", "svg")),
                    title: visitEncounterModel!.data!.doctor!.specialty!??'',//AppConstants.docTitle,
                    subTitle: visitEncounterModel!.data!.doctor!.title+" "+visitEncounterModel!.data!.doctor!.name,//AppConstants.docName,
                    trailing: const Padding(
                      padding: EdgeInsets.only(
                          left: 8, top: 4.0, right: 4.0, bottom: 8.0),
                      child: Icon(Icons.more_horiz),
                    ),
                    date:  DateFormat('d MMM y').format(
                        DateTime.parse((visitEncounterModel.data!.visitDate.toString()))),//AppConstants.docDate,
                    time:  DateFormat('hh:mm').format(
                        DateTime.parse((visitEncounterModel.data!.visitDate.toString()))), ///AppConstants.docTime,
                  ):Container(),

                  const HorizontalLine(height: 1),

                  Container(
                      width: Helper.getScreenWidth(context),
                      padding: const EdgeInsets.only(left: 8.0,bottom: 8.0),
                      margin: const EdgeInsets.only(left: 16, top: 16.0,right: 16.0),
                      decoration: BoxDecoration(
                          color: AppConstants.darkOrange.withAlpha(60),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: visitEncounterModel != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0, right: 16.0),
                                    child: Text(
                                      "Diagnostic Reports",
                                      style:
                                          AppConstants.subLabelLightTextStyle(
                                              FontWeight.w700,
                                              AppConstants.blackColor),
                                    )),
                                diagnosisWidget(
                                    visitEncounterModel.data!.diagnosis!.items),
                              ],
                            )
                          : Column(
                              children: [
                                ClinicalListTileWidget(
                                  icon: SvgPicture.asset(Helper.getAssetSVGName(
                                      "encounterDiagnostics", "svg")),
                                  title: 'No Requested',
                                  subTitle:
                                      "No request sent for this encounter",
                                  description: "Diagnostic Report",
                                  backGroundColor: AppConstants.darkOrange,
                                  onTab: () {
                                    /* Helper.navigateToNextPage(
                                        context,
                                        ClinicalAccessControlScreen(
                                          clinicalVisits: [],
                                          //widget.clinicalVisits,
                                          visitsDetails: widget.visitsDetails,
                                          // diagnosisReports: widget.diagnosisReports
                                        ));*/
                                  },
                                  isTrail: false,
                                ),
                              ],
                            )),
                  visitEncounterModel != null
                      ? prescriptionsWidget(
                          visitEncounterModel.data!.prescriptions)
                      : Container(
                          width: Helper.getScreenWidth(context),
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(
                              left: 16, top: 8, bottom: 8, right: 16),
                          decoration: BoxDecoration(
                              color: AppConstants.greenColor.withAlpha(60),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              ClinicalListTileWidget(
                                icon: SvgPicture.asset(Helper.getAssetSVGName(
                                    "encounterPrescriptions", "svg")),
                                title: 'No Prescription Sent',
                                subTitle:
                                    "No prescriptions sent for this encounter",
                                description: "Prescriptions",
                                backGroundColor: AppConstants.greenColor,
                                onTab: () {
                                  /*Helper.navigateToNextPage(
                                      context,
                                      ClinicalAccessControlScreen(
                                        clinicalVisits: [],
                                        //widget.clinicalVisits,
                                        visitsDetails: widget.visitsDetails,
                                        // diagnosisReports: widget.diagnosisReports
                                      ));*/
                                },
                              ),
                            ],
                          )),
                  visitEncounterModel != null
                      ? notesWidget(visitEncounterModel.data!.prescriptions)
                      : Container(
                          width: Helper.getScreenWidth(context),
                          padding: const EdgeInsets.all(0.0),
                          margin: const EdgeInsets.only(left: 8, right: 8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: Helper.getScreenWidth(context),
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.only(
                                      left: 8, top: 8, bottom: 8, right: 8),
                                  decoration: BoxDecoration(
                                      color: AppConstants.primaryColor
                                          .withAlpha(60),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    children: [
                                      ClinicalListTileWidget(
                                        icon: SvgPicture.asset(
                                            Helper.getAssetSVGName(
                                                "encounterHistory", "svg")),
                                        title: 'No Notes',
                                        subTitle:
                                            "No notes submitted for this encounter",
                                        description:
                                            "History & Examination Findings",
                                        backGroundColor:
                                            AppConstants.primaryColor,
                                        onTab: () {
                                          /*Helper.navigateToNextPage(
                                              context,
                                              ClinicalAccessControlScreen(
                                                  clinicalVisits: [],
                                                  visitsDetails:
                                                      widget.visitsDetails));*/
                                        },
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        )));
  }

  //--
  diagnosisWidget(List<DiagnosisItem> diagnostic) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: diagnostic
                  .map((item) => Column(
                        children: <Widget>[
                          ClinicalListTileWidget(
                            icon: SvgPicture.asset(Helper.getAssetSVGName(
                                "encounterDiagnostics", "svg")),
                            title: item.fullName,
                            subTitle:  DateFormat('d MMM y').format(
                                DateTime.parse(item.date.toString())),
                            backGroundColor: AppConstants.darkOrange,
                            onTab: () {
                              Helper.navigateToNextPage(
                                  context,
                                  DiagnosisDetailsScreen(
                                    visitEncounterModel: visitEncounterModel,
                                  ));
                            },
                            isTrail: true,
                          )
                        ],
                      ))
                  .toList(),
            )
          ],
        ));
  }

  //visitEncounterModel.data!.prescriptions

  prescriptionsWidget(List<VisitPrescription> prescription) {
    return Container(
        width: Helper.getScreenWidth(context),
        padding: const EdgeInsets.only(
            left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: AppConstants.greenColor.withAlpha(60),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Prescriptions",
              style: AppConstants.subLabelLightTextStyle(
                  FontWeight.w700, AppConstants.blackColor),
            ),
            ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: prescription
                  .map((item) => Column(
                        children: <Widget>[
                          ListView(
                            shrinkWrap: true,
                            children: item.items!
                                .map((prescription) => Column(
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            ClinicalListTileWidget(
                                              icon: SvgPicture.asset(
                                                  Helper.getAssetSVGName(
                                                      "encounterPrescriptions",
                                                      "svg")),
                                              title: prescription.name,
                                              subTitle:  DateFormat('d MMM y').format(
                                                  DateTime.parse(prescription.insertedAt.toString())),
                                              backGroundColor:
                                                  AppConstants.greenColor,
                                              onTab: () {
                                                Helper.navigateToNextPage(
                                                    context,
                                                    PrescriptionScreen(
                                                        prescription: []));
                                              },
                                              isTrail: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ));
  }

  notesWidget(List<VisitPrescription> prescription) {
    return Container(
        width: Helper.getScreenWidth(context),
        padding: const EdgeInsets.only(
            left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: AppConstants.primaryColor.withAlpha(60),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notes",
              style: AppConstants.subLabelLightTextStyle(
                  FontWeight.w700, AppConstants.blackColor),
            ),
            ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: prescription
                  .map((item) => Column(
                        children: <Widget>[
                          Column(
                            children: [
                              ClinicalListTileWidget(
                                icon: SvgPicture.asset(Helper.getAssetSVGName(
                                    "encounterHistory", "svg")),
                                title: item.notes ?? '',
                                subTitle:
                                    '' /* DateFormat('d MMM y').format(DateTime.parse(item.data!.insertedAt.toString())),*/
                                ,
                                backGroundColor: AppConstants.primaryColor,
                                onTab: () {
                                  Helper.navigateToNextPage(
                                      context,
                                      EncounterExaminationsScreen(
                                        diagnostic: [],
                                        visitEncounterModel: visitEncounterModel,
                                        category:APIConstants.prescriptions,
                                      ));
                                },
                                isTrail: true,
                              ),
                            ],
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ));
  }

  void executeClinicalVisitsDetailsCall(BuildContext context, int visitID) {
    //Map map = Map();
    loadProgress();
    String clinicalVisitsEndpoint = APIConstants.clinicalVisitsEndpoint;
    // String visits = APIConstants.visits;
    String slash = APIConstants.slash;

    apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl).apiParam({},'',
        '$clinicalVisitsEndpoint$slash$slash$visitID',
        APIConstants.getRequestMethod,
        context);

    apiCall?.then((value) {
      // var responseJson = json.decode(jsonEncode(value));
      // int statusCode = responseJson['code'];
      //String statusMessage = responseJson['message'];

      var decodeJson = json.decode(jsonEncode(value));
      var decodeJsonData = decodeJson['data'];

       visitEncounterModel = visitEncounterModelFromJson(jsonEncode(value));

      print("D list");
      print(visitEncounterModel.data!.diagnosis!.items);
      print(visitEncounterModel.data!.prescriptions.toString());
      print(visitEncounterModel.data!.attachments);
      print(visitEncounterModel.data!.visitDate);

      if (decodeJsonData != null) {
        setState(() {
          visitAttachmentData = List<VisitAttachment>.from(
              decodeJsonData['attachments']
                  .map((x) => VisitAttachment.fromJson(x)));

          visitDiagnosisData = List<DiagnosisItem>.from(
              decodeJsonData['diagnosis']['items']
                  .map((x) => DiagnosisItem.fromJson(x)));
          /*decodeJsonData['attachments']
              .map<VisitAttachment>((json) => VisitAttachment.fromJson(json))
              .toList();*/
        });

        print("VISIT DETAILS ATTACHMENT");
        print(decodeJsonData['attachments']);
        print("VISIT DETAILS ATTACHMENT 2");
        print(visitAttachmentData.length.toString());
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
