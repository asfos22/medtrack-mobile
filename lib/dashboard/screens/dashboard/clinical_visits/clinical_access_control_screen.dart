import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/dashboard/screens/dashboard/clinical_visits/access_control_expanded_screen.dart';
import 'package:medtrack/dashboard/screens/dashboard/encounter_actions/diagnosis_details_screen.dart';
import 'package:medtrack/dashboard/screens/dashboard/encounter_actions/encounter_examinations_screen.dart';
import 'package:medtrack/dashboard/screens/dashboard/prescriptions_list/prescription_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/access_mgt_list_tile_widget.dart';
import 'package:medtrack/widgets/clinical_list_tile_widget.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/doc_section.dart';
import 'package:medtrack/widgets/dragging_handle.dart';
import 'package:medtrack/widgets/prescription_card.dart';

import '../../../../constants/api_constants.dart';

class ClinicalAccessControlScreen extends StatefulWidget {
  // visits
  final List<Visit> clinicalVisits;
  final List<VisitsDetail>? visitsDetails;

  const ClinicalAccessControlScreen(
      {Key? key, required this.clinicalVisits, required this.visitsDetails})
      : super(key: key);

  @override
  _ClinicalAccessControlScreenState createState() =>
      _ClinicalAccessControlScreenState();
}

class _ClinicalAccessControlScreenState
    extends State<ClinicalAccessControlScreen> {
  List<AccessControl> accessControl = [];

  @override
  void initState() {
    super.initState();

    for (var visit in widget.visitsDetails!) {
      accessControl = visit.accessControl!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        bottomSheet: Container(
            color: AppConstants.secondaryBackGround,
            height: 92,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppConstants.whiteColor,
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(2),
                    height: 24,
                    child: const DraggingHandle(),
                  ),
                  AccessMgtListTileWidget(
                    title: const Text("Access Control"),
                    subTitle: "3 doctors have access to this session",
                    trailing: TextButton(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, top: 4.0, right: 4.0, bottom: 8.0),
                        child: Text('Manage',
                            style: TextStyle(
                                color: AppConstants.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      ),
                      style: TextButton.styleFrom(
                        primary: AppConstants.colorRed,
                        onSurface: AppConstants.colorRed,
                        backgroundColor: AppConstants.colorRed,
                        fixedSize: const Size(85, 42),
                        side:
                            BorderSide(color: AppConstants.colorRed, width: 8),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                      ),
                      onPressed: () {
                        Helper.navigateToNextPage(
                            context,
                            AccessControlExpandedScreen(
                                accessControl: accessControl));
                      },
                    ),
                    backGroundColor: AppConstants.whiteColor,
                  )
                ],
              ),
            )),
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "Encounter",
              subTitle: Container(),
              backgroundColor: AppConstants.primaryColor,
            )),
        body: SafeArea(
            child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 32),
                itemCount: widget.visitsDetails!.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: 64),
                    child: Column(
                      children: [
                        DocSection(
                            icon: SvgPicture.asset(Helper.getAssetSVGName(
                                "iconDarkPerson", "svg")),
                            title:
                                (widget.visitsDetails![index].contact!.title!),
                            //AppConstants.docTitle,
                            subTitle:
                                (widget.visitsDetails![index].contact!.name!),
                            //AppConstants.docName,
                            trailing: GestureDetector(
                                onTap: () => Helper.showActionModalBottomSheet(
                                    context,
                                    false,
                                    PrescriptionCard(
                                        "Call Physician",
                                        AppConstants.docTitle,
                                        widget.visitsDetails![index].contact!
                                            .name!,
                                        AppConstants.subLabelColor,
                                        false,
                                        widget
                                            .visitsDetails![index]
                                            .reports![index]
                                            .report![index]
                                            .physician!
                                            .contact!
                                            .phoneNumber!,
                                        widget
                                            .visitsDetails![index]
                                            .reports![index]
                                            .report![index]
                                            .physician!
                                            .contact!
                                            .location)),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 8,
                                      top: 4.0,
                                      right: 4.0,
                                      bottom: 8.0),
                                  child: Icon(Icons.more_horiz),
                                )),
                            date: (widget.visitsDetails![index].date!),
                            //AppConstants.docDate,
                            time: (widget.visitsDetails![index]
                                .time) //AppConstants.docTime,
                            ),
                        completedWidget(widget.visitsDetails![index].reports,
                            widget.clinicalVisits[index].diagnosis!),
                        Container(
                            width: Helper.getScreenWidth(context),
                            padding: const EdgeInsets.only(left: 1.0),
                            margin:
                                const EdgeInsets.only(left: 16, right: 16.0),
                            decoration: BoxDecoration(
                                color: AppConstants.darkOrange.withAlpha(60),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 8.0, right: 16.0),
                                    child: Text(
                                      "Diagnostic Reports",
                                      style:
                                          AppConstants.subLabelLightTextStyle(
                                              FontWeight.w700,
                                              AppConstants.blackColor),
                                    )),
                                diagnosisWidget(widget.visitsDetails![index],
                                    widget.clinicalVisits[index].diagnosis!)
                              ],
                            )),
                        prescriptionsWidget(widget.visitsDetails![index],
                            widget.clinicalVisits[index].prescriptions!)
                      ],
                    ),
                  );
                })));
  }

  diagnosisWidget(VisitsDetail visit, List<Diagnosis> diagnostic) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: visit.reports!
                  .map((item) => Column(
                        children: <Widget>[
                          ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: item.report!
                                .map((report) => Column(
                                      children: <Widget>[
                                        item.code == AppConstants.diagnosis
                                            ? ClinicalListTileWidget(
                                                icon: SvgPicture.asset(
                                                    Helper.getAssetSVGName(
                                                        "encounterDiagnostics",
                                                        "svg")),
                                                title: report.name,
                                                subTitle: report.createdAt,
                                                backGroundColor:
                                                    AppConstants.darkOrange,
                                                onTab: () {
                                                  Helper.navigateToNextPage(
                                                      context,
                                                      DiagnosisDetailsScreen(
                                                          diagnosis:
                                                              diagnostic));
                                                },
                                                isTrail: true,
                                              )
                                            : Container(),
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

  prescriptionsWidget(VisitsDetail visit, List<Prescription>? prescription) {
    return Container(
        width: Helper.getScreenWidth(context),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: AppConstants.greenColor.withAlpha(60),
            borderRadius: BorderRadius.circular(8)),
        child: visit.reports != null
            ? Column(
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
                    children: visit.reports!
                        .map((item) => Column(
                              children: <Widget>[
                                ListView(
                                  shrinkWrap: true,
                                  children: item.report!
                                      .map((report) => Column(
                                            children: <Widget>[
                                              item.code ==
                                                      AppConstants.prescriptions
                                                  ? Column(
                                                      children: [
                                                        ClinicalListTileWidget(
                                                          icon: SvgPicture.asset(
                                                              Helper.getAssetSVGName(
                                                                  "encounterPrescriptions",
                                                                  "svg")),
                                                          title:
                                                              'Acute Migraine',
                                                          subTitle:
                                                              "1st Jan 2021",
                                                          backGroundColor:
                                                              AppConstants
                                                                  .greenColor,
                                                          onTab: () {
                                                            Helper.navigateToNextPage(
                                                                context,
                                                                PrescriptionScreen(
                                                                    prescription:
                                                                        prescription));
                                                          },
                                                          isTrail: true,
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                ],
              )
            : Container(
                width: Helper.getScreenWidth(context),
                padding: const EdgeInsets.all(8.0),
                margin:
                    const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                decoration: BoxDecoration(
                    color: AppConstants.greenColor.withAlpha(60),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    ClinicalListTileWidget(
                      icon: SvgPicture.asset(Helper.getAssetSVGName(
                          "encounterPrescriptions", "svg")),
                      title: 'No Prescription Sent',
                      subTitle: "No prescriptions sent for this encounter",
                      description: "Prescriptions",
                      backGroundColor: AppConstants.greenColor,
                      onTab: () {},
                    ),
                  ],
                )));
  }

  completedWidget(
      List<VisitsDetailReport>? reports, List<Diagnosis> diagnostic) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: Helper.getScreenWidth(context),
                padding: const EdgeInsets.all(0.0),
                margin: const EdgeInsets.only(left: 8, right: 8.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                child: ListView(
                  shrinkWrap: true,
                  children: reports!
                      .map((item) => Column(
                            children: <Widget>[
                              ListView(
                                shrinkWrap: true,
                                children: item.report!
                                    .map((report) => Column(
                                          children: <Widget>[
                                            //-- completed
                                            item.code == AppConstants.completed
                                                ? Container(
                                                    width:
                                                        Helper.getScreenWidth(
                                                            context),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 8,
                                                            top: 8,
                                                            bottom: 8,
                                                            right: 8),
                                                    decoration: BoxDecoration(
                                                        color: AppConstants
                                                            .primaryColor
                                                            .withAlpha(60),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              Helper.navigateToNextPage(
                                                                  context,
                                                                  SingleChildScrollView(
                                                                    child: PrescriptionCard(
                                                                        "Call Facility",
                                                                        AppConstants
                                                                            .docTitle,
                                                                        AppConstants
                                                                            .docName,
                                                                        AppConstants
                                                                            .subLabelColor,
                                                                        false,
                                                                        '',
                                                                        ''),
                                                                  ));
                                                            },
                                                            child:
                                                                ClinicalListTileWidget(
                                                              icon: SvgPicture
                                                                  .asset(Helper
                                                                      .getAssetSVGName(
                                                                          "encounterHistory",
                                                                          "svg")),
                                                              title:
                                                                  report.name,
                                                              subTitle: report
                                                                  .createdAt,
                                                              backGroundColor:
                                                                  AppConstants
                                                                      .primaryColor,
                                                              onTab: () {
                                                                Helper.navigateToNextPage(
                                                                    context,
                                                                    EncounterExaminationsScreen(
                                                                        diagnostic:
                                                                         diagnostic, visitEncounterModel: null,
                                                                    category:APIConstants.investigations,
                                                                    ));
                                                              },
                                                              isTrail: true,
                                                            )),
                                                      ],
                                                    ))
                                                : Container(),
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ],
                          ))
                      .toList(),
                )),
          ],
        ));
  }
}
