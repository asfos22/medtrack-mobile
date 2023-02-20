import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/doc_section.dart';
import 'package:medtrack/widgets/horizontal_line.dart';
import 'package:medtrack/widgets/list_tile_default_widget.dart';

import '../../../../constants/api_constants.dart';
import '../../../../repository/network/api_repository.dart';
import '../../../../widgets/custom_alert_dialog.dart';
import '../../../../widgets/empty_state_card.dart';
import '../../../../widgets/loading_view.dart';
import '../../../models/clinical_visits/visit_encounter_model.dart';
import '../../../models/diagnosis/diagnosis_model.dart';

class EncounterExaminationsScreen extends StatefulWidget {
  final List<Diagnosis> diagnostic;
  final bool makeAPICall;
  final VisitEncounterModel? visitEncounterModel;
  final DiagnosisDatum? diagnosisDatum;
  final String category;

  const EncounterExaminationsScreen(
      {Key? key,
      required this.diagnostic,
      this.makeAPICall = false,
      this.visitEncounterModel,
      this.diagnosisDatum,
      required this.category})
      : super(key: key);

  @override
  _EncounterExaminationsScreenState createState() =>
      _EncounterExaminationsScreenState();
}

class _EncounterExaminationsScreenState
    extends State<EncounterExaminationsScreen> {
  List<dynamic> diagnosis = [];
  Future<dynamic>? apiCall;
  late DiagnosisModel? diagnosisDatum;
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
        await rootBundle.loadString('assets/encounter_list.json');
    final data = await json.decode(response);

    setState(() {
      diagnosis =
          data['diagnosis'].map((data) => Diagnosis.fromJson(data)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // readJson();

    /// Hi Joel , please l'm simulating api base on param argument
    /// Reference Diagnostic screen  & Encounter examination screen
    if (widget.makeAPICall == true &&
        widget.diagnosisDatum != null &&
        widget.category == APIConstants.investigations) {
      // readJson();
      print("DIAGNOSTICS");
      print(widget.diagnosisDatum!.id);
      executeDiagnosticDetailsCall(
          context, int.parse(widget.diagnosisDatum!.id.toString()));
    } else {
      setState(() {
        diagnosis = widget.diagnostic;
      });
    }

    print("History");
    print(widget.category);
    /* print(widget.visitEncounterModel!.data!.doctor!.title!);
    print(widget.visitEncounterModel!.data!.doctor!.specialty!);
    print(widget.visitEncounterModel!.data!.doctor!.name!);
    print(widget.visitEncounterModel!.data!.visitDate!.hour);
    print(widget.visitEncounterModel!.data!.visitDate!.minute);
    print(widget.visitEncounterModel!.data!.clinicalSummary);*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppConstants.secondaryBackGround,
            appBar: PreferredSize(
                preferredSize: const Size(
                    double.infinity, AppConstants.defaultAppBarSizeHeight),
                child: CustomAppBar(
                  title: "History & Exam...",
                  subTitle: Container(),
                  backgroundColor: AppConstants.primaryColor,
                )),
            body: visible == false
                ? ListView(
                    children: [
                      widget.category == APIConstants.investigations
                          ? diagnosticsMainItem(diagnosisDatum)
                          : widget.category == APIConstants.prescriptions &&
                                  widget.visitEncounterModel != null
                              ? prescriptionsMainItem(
                                  widget.visitEncounterModel!)
                              : Container(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  margin: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  width: double.infinity,
                                  child: _emptyMainContainer())
                    ],
                  )
                : const LoadingView() /*ListView(
              children: [
                widget.visitEncounterModel != null
                    ? mainItem(widget.visitEncounterModel!)
                    : Container(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                        width: double.infinity,
                        child: _emptyMainContainer())
              ],
            )*/

            )); /*ListView.builder(
                itemCount: diagnosis.length,
                itemBuilder: (context, index) {
                  return mainItem(diagnosis[index]);
                })))*/
  }

  diagnosticsMainItem(DiagnosisModel? diagnosis) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: diagnosis!.data!
                      .map((item) => Column(
                            children: <Widget>[
                              Container(
                                color: AppConstants.whiteColor,
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: DocSection(
                                    icon: SvgPicture.asset(
                                        Helper.getAssetSVGName(
                                            "iconDarkPerson", "svg")),
                                    title: "Data neeeded",
                                    //encounter.items!.doctor!.specialty!,
                                    subTitle:
                                        "Data needed" /*encounter.data!.doctor!.title! +
                      " " +
                      encounter.data!.doctor!.name!*/
                                    ,
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8,
                                          top: 4.0,
                                          right: 4.0,
                                          bottom: 8.0),
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: AppConstants.greyColor,
                                      ),
                                    ),
                                    date: DateFormat('d MMM y').format(
                                        DateTime.parse(
                                            item.insertedAt?.toString() ?? '')),
                                    //encounter.data.doctor,
                                    time: DateFormat('hh:mm').format(
                                        DateTime.parse(
                                            item.insertedAt?.toString() ??
                                                '')) //"times" //encounter.time,
                                    ),
                              ),
                              Container(
                                  width: Helper.getScreenWidth(context),
                                  margin: const EdgeInsets.only(
                                      left: 0, top: 8.0, right: 0.0),
                                  decoration: BoxDecoration(
                                      color: AppConstants.whiteColor,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: Helper.getScreenWidth(context),
                                          margin: const EdgeInsets.only(
                                              left: 8, top: 8, right: 8),
                                          decoration: BoxDecoration(
                                              color: AppConstants.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: ListTileDefaultWidget(
                                              title: "Notes",
                                              subTitle: Text(
                                                  'Investigation needed',
                                                  style: AppConstants
                                                      .subLabelLightTextStyle(
                                                          FontWeight.w500,
                                                          AppConstants
                                                              .subLabelColor)),
                                              //encounter.title,
                                              onTab: () {})),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const HorizontalLine(height: 1),
                                      Container(
                                        width: Helper.getScreenWidth(context),
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.only(
                                            left: 16,
                                            top: 8,
                                            bottom: 16,
                                            right: 16),
                                        decoration: BoxDecoration(
                                            color: AppConstants.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(item.clinicalSummary ?? '',
                                            style: AppConstants
                                                .bodyCopyDarkTextStyle),
                                      ),
                                    ],
                                  )
                                  /*ListView(
                          shrinkWrap: true,
                          children: item.items!
                              .map((prescription) => Column(
                            children: <Widget>[

                            ],
                          ))
                              .toList(),
                        ),*/
                                  )
                            ],
                          ))
                      .toList(),
                ),
              ],
            ),
          ],
        ));
  }

  prescriptionsMainItem(VisitEncounterModel encounter) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: AppConstants.whiteColor,
              margin: const EdgeInsets.only(bottom: 8.0),
              child: DocSection(
                  icon: SvgPicture.asset(
                      Helper.getAssetSVGName("iconDarkPerson", "svg")),
                  title: encounter.data!.doctor!.specialty!,
                  subTitle: encounter.data!.doctor!.title! +
                      " " +
                      encounter.data!.doctor!.name!,
                  trailing: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, top: 4.0, right: 4.0, bottom: 8.0),
                    child: Icon(
                      Icons.more_horiz,
                      color: AppConstants.greyColor,
                    ),
                  ),
                  date: DateFormat('d MMM y').format(
                      DateTime.parse(encounter.data!.insertedAt.toString())),
                  //encounter.data.doctor,
                  time: DateFormat('hh:mm').format(DateTime.parse(encounter
                      .data!.insertedAt
                      .toString())) //"times" //encounter.time,
                  ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: encounter.data!.prescriptions!
                      .map((item) => Column(
                            children: <Widget>[
                              Container(
                                  width: Helper.getScreenWidth(context),
                                  margin: const EdgeInsets.only(
                                      left: 0, top: 8.0, right: 0.0),
                                  decoration: BoxDecoration(
                                      color: AppConstants.whiteColor,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: Helper.getScreenWidth(context),
                                          margin: const EdgeInsets.only(
                                              left: 8, top: 8, right: 8),
                                          decoration: BoxDecoration(
                                              color: AppConstants.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: ListTileDefaultWidget(
                                              title: "Notes",
                                              subTitle: Text(item.notes ?? '',
                                                  style: AppConstants
                                                      .subLabelLightTextStyle(
                                                          FontWeight.w500,
                                                          AppConstants
                                                              .subLabelColor)),
                                              //encounter.title,
                                              onTab: () {})),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const HorizontalLine(height: 1),
                                      Container(
                                        width: Helper.getScreenWidth(context),
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.only(
                                            left: 16,
                                            top: 8,
                                            bottom: 16,
                                            right: 16),
                                        decoration: BoxDecoration(
                                            color: AppConstants.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                            widget.visitEncounterModel!.data!
                                                    .clinicalSummary ??
                                                '',
                                            style: AppConstants
                                                .bodyCopyDarkTextStyle),
                                      ),
                                    ],
                                  )
                                  /*ListView(
                          shrinkWrap: true,
                          children: item.items!
                              .map((prescription) => Column(
                            children: <Widget>[

                            ],
                          ))
                              .toList(),
                        ),*/
                                  )
                            ],
                          ))
                      .toList(),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _emptyMainContainer() {
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
      headerLabel: 'Empty Examination State Title',
      subLabel: 'Prescriptions from your clinical visits will appear here.',
      onTap: () => {},
    );
  }

  void executeDiagnosticDetailsCall(BuildContext context, int id) {
    //Map map = Map();
    loadProgress();

    String baseURL = APIConstants.diagnosticsEndpoint;
    String slash = APIConstants.slash;

    print("DIAGNOSTIC DETAILS");
    print('$baseURL$slash$id');

    apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl).apiParam(
        {}, '', '$baseURL$slash$id', APIConstants.getRequestMethod, context);

    apiCall?.then((value) {
      // var responseJson = json.decode(jsonEncode(value));
      // int statusCode = responseJson['code'];
      //String statusMessage = responseJson['message'];

      var decodeJson = json.decode(jsonEncode(value));
      var decodeJsonData = decodeJson['data'];

      print("DATA DATA D");
      diagnosisDatum = diagnosisModelFromJson(jsonEncode(value));
      print(diagnosisDatum!.data.toString());

      /*print("D list");
      print(visitEncounterModel.data!.diagnosis!.items);
      print(visitEncounterModel.data!.prescriptions.toString());
      print(visitEncounterModel.data!.attachments);*/

      if (decodeJsonData != null) {
        setState(() {
          print("DIAGNOSIC DETAILS");
        });

        // print("VISIT DETAILS ATTACHMENT");
        // print(decodeJsonData['attachments']);
        print("DIAGNOSIS");
        //print( diagnosisDatum!.length.toString());
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
