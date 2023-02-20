import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/repository/network/api_repository.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/list_tile_widget.dart';

import '../../../../constants/api_constants.dart';
import '../../../../widgets/custom_alert_dialog.dart';
import '../../../../widgets/loading_view.dart';
import '../../../models/diagnosis/diagnosis_model.dart';
import 'encounter_examinations_screen.dart';

class DiagnosticScreen extends StatefulWidget {
  final List<DiagnosisReport>? diagnosisReport;

  const DiagnosticScreen({Key? key, required this.diagnosisReport})
      : super(key: key);

  @override
  _DiagnosticScreenState createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  List<dynamic>? diagnosis = [];
  dynamic visitEncounterModel;
  late List<DiagnosisDatum>? diagnosisDatum = [];

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
      diagnosis = data['items'][2]['diagnosis_reports']
          .map((data) => DiagnosisReport.fromJson(data))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      diagnosis = widget.diagnosisReport ?? [];
    });

    executeDiagnosticDetailsCall(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.secondaryBackGround,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "Diagnostics",
              subTitle: Container(),
              backgroundColor: AppConstants.primaryColor,
            )),
        body: SafeArea(
            child: visible == false
                ? ListView.builder(
                    itemCount: diagnosis!.length,
                    itemBuilder: (context, index) {
                      return mainItem(diagnosis![index] ?? []);
                    })
                : const LoadingView()));
  }

  mainItem(DiagnosisReport diagnosisReport) {

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.only(left: 0, right: 8.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
              child: diagnosisDatum != null
                  ? ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: diagnosisDatum! //diagnosisReport.diagnostics!
                          .map((item) => Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 24.0,
                                        right: 16.0,
                                        top: 2.0,
                                        bottom: 2.0),
                                    width: Helper.getScreenWidth(context),
                                    decoration: BoxDecoration(
                                      color: AppConstants.borderLineColor
                                          .withOpacity(0.5),
                                      border: Border.all(
                                        color: AppConstants.borderLineColor,
                                      ),
                                    ),
                                    child: Text(
                                      item.insertedAt?.year.toString() ?? '',
                                      style: TextStyle(
                                        color: AppConstants.subLabelColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  ListTileWidget(
                                    icon: SvgPicture.asset(
                                        Helper.getAssetSVGName(
                                            "iconDarkEncounter", "svg")),
                                    title: item.clinicalSummary,
                                    subTitle: DateFormat('d MMM y').format(
                                        DateTime.parse(
                                            item.insertedAt.toString())),
                                    //formattedDate.toString(),//DateTime(item.insertedAt!.day, item.insertedAt!.month ).toString(),//item.insertedAt.toString(),
                                    onTab: () {
                                      Helper.navigateToNextPage(
                                          context,
                                          EncounterExaminationsScreen(
                                            makeAPICall: true,
                                            diagnosisDatum: item,
                                            category:
                                                APIConstants.investigations,
                                            diagnostic: const [],
                                          ));
                                    },
                                    backGroundColor:
                                        AppConstants.artBoardBackground,
                                    trailingIcon:
                                        Icons.arrow_forward_ios_outlined,
                                  ),
                                ],
                              ))
                          .toList(),
                    )
                  : Text("No data"),
            ),
          ],
        ));
  }

  void executeDiagnosticDetailsCall(BuildContext context) {
    loadProgress();

    apiCall = APIRepository(baseUrl: APIConstants.apiBaseUrl).apiParam({},'',
        APIConstants.diagnosticsEndpoint,
        APIConstants.getRequestMethod,
        context);

    apiCall?.then((value) {
      // int statusCode = responseJson['code'];
      //String statusMessage = responseJson['message'];

      var decodeJson = json.decode(jsonEncode(value));
      var decodeJsonData = decodeJson['data'];

      /*
      print(visitEncounterModel.data!.diagnosis!.items);
      print(visitEncounterModel.data!.prescriptions.toString());
      print(visitEncounterModel.data!.attachments);*/

      if (decodeJsonData != null) {
        setState(() {
          diagnosisDatum = List<DiagnosisDatum>.from(
              decodeJsonData.map((x) => DiagnosisDatum.fromJson(x)));
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
