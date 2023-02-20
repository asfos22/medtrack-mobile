import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/dashboard/screens/empty/history_empty_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/chip_widget.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/doc_section.dart';
import 'package:medtrack/widgets/horizontal_line.dart';
import 'package:medtrack/widgets/list_tile_default_widget.dart';

import '../../../models/clinical_visits/visit_encounter_model.dart';

class DiagnosisDetailsScreen extends StatefulWidget {
  final List<dynamic>? diagnosis;
  final VisitEncounterModel? visitEncounterModel;

  const DiagnosisDetailsScreen(
      {Key? key, this.diagnosis, this.visitEncounterModel})
      : super(key: key);

  @override
  _DiagnosisDetailsScreenState createState() => _DiagnosisDetailsScreenState();
}

class _DiagnosisDetailsScreenState extends State<DiagnosisDetailsScreen> {
  @override
  void initState() {
    super.initState();
    print("DIAGNOSIS 101");
    print(widget.visitEncounterModel!.data!.clinicalSummary);
    print(widget.visitEncounterModel!.data!.doctor!.name);
    print(widget.visitEncounterModel!.data!.doctor!.name);
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
            child: ListView(
          children: [
            widget.visitEncounterModel != null
                ? mainItem(widget.visitEncounterModel)
                : Text("No Data")
          ],
        ) /*ListView.builder(
                itemCount: widget.diagnosis!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () =>(){} /*Helper.navigateToNextPage(
                        context, const HistoryEmptyScreen())*/,
                    child: mainItem(widget.diagnosis![index]),
                  );
                })*/
            ));
  }

  mainItem(VisitEncounterModel? diagnosis) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            diagnosis!.data!.doctor!=null?DocSection(
              icon: SvgPicture.asset(
                  Helper.getAssetSVGName("iconDarkPerson", "svg")),
              title: widget.visitEncounterModel!.data!.doctor!.specialty??'',//AppConstants.docTitle,
              subTitle: widget.visitEncounterModel!.data!.doctor!.title??''+widget.visitEncounterModel!.data!.doctor!.name!,//AppConstants.docName,
              trailing: const Padding(
                padding: EdgeInsets.only(
                    left: 8, top: 4.0, right: 4.0, bottom: 8.0),
                child: Icon(Icons.more_horiz),
              ),
              date:  DateFormat('d MMM y').format(
                  DateTime.parse((widget. visitEncounterModel!.data!.visitDate.toString()))),//AppConstants.docDate,
              time:  DateFormat('hh:mm').format(
                  DateTime.parse((widget. visitEncounterModel!.data!.visitDate.toString()))), ///AppConstants.docTime,
            ):Container(),

            Container(
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.only(left: 0, top: 8.0, right: 0.0),
              decoration: BoxDecoration(
                  color: AppConstants.whiteColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 32.0, right: 16.0),
                      child: Text("Investigations",
                          style: AppConstants.h2HeadingTextStyle)),
                  Container(
                    margin: const EdgeInsets.only(left: 0.0, right: 16.0),
                    child: ListTileDefaultWidget(
                        subTitle: ListView(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: diagnosis.data!.diagnosis!.items!
                              .map((item) => Column(
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Container(
                                              width: Helper.getScreenWidth(
                                                  context),
                                              margin: const EdgeInsets.only(
                                                  left: 0, top: 0, right: 8),
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppConstants.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: ListTileDefaultWidget(
                                                  subTitle: Text(
                                                      item.fullName ?? '',
                                                      style: AppConstants
                                                          .subLabelLightTextStyle(
                                                              FontWeight.w500,
                                                              AppConstants
                                                                  .subLabelColor)),
                                                  //encounter.title,
                                                  onTab: () {})),
                                        ],
                                      )
                                    ],
                                  ))
                              .toList(),
                        ),
                        onTab: () {}),
                  ),
                  const HorizontalLine(height: 1),
                  Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 16),
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 8.0,
                      right: 16.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 0.0,
                          children: List<Widget>.generate(
                              diagnosis.data!.diagnosis!.items!.length,
                              // place the length of the array here
                              (int index) {
                            return ChipWidget(
                              //listTag: diagnosis.investigations!.tags,
                              tags: <TagWidget>[
                                TagWidget(
                                  diagnosis.data!.diagnosis!.items![index].fullCode!,
                                  AppConstants.primaryColor,
                                ),
                              ],
                              selected: (bool value) {},
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Helper.getScreenWidth(context),
              margin: const EdgeInsets.only(top: 16.0),
              decoration: BoxDecoration(
                  color: AppConstants.whiteColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: Helper.getScreenWidth(context),
                      margin: const EdgeInsets.only(
                          left: 16.0, top: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                          color: AppConstants.whiteColor,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: ListTileDefaultWidget(
                          title: "Attachment",
                          subTitle: Text(
                              "Report document attachment uploaded by diagnostic center",
                              style: AppConstants.subLabelLightTextStyle(
                                  FontWeight.w500, AppConstants.subLabelColor)),
                          // "Report document attachment uploaded by diagnostic center",
                          onTab: () {})),
                  const SizedBox(
                    height: 16,
                  ),
                  const HorizontalLine(height: 1),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 16.0, top: 8.0, bottom: 8.0, right: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 0.0,
                          children: List<Widget>.generate(
                              widget.visitEncounterModel!.data!.attachments!
                                  .length,
                              // place the length of the array here
                              (int index) {
                            return Container(
                              width: Helper.getScreenWidth(context) / 4,
                              padding: const EdgeInsets.all(0.0),
                              margin: const EdgeInsets.all(4.0),
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.network(
                                  widget.visitEncounterModel!.data!
                                      .attachments![index].fileName!,
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 1,
                                margin: const EdgeInsets.all(2),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.only(top: 16.0),
              margin: const EdgeInsets.only(top: 16.0, right: 0.0),
              decoration: BoxDecoration(
                  color: AppConstants.whiteColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListView(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: diagnosis.data!.prescriptions!
                        .map((item) => Column(
                              children: <Widget>[
                                Column(
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
                                  ],
                                )
                              ],
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const HorizontalLine(height: 1),
                  Container(
                    width: Helper.getScreenWidth(context),
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(
                        left: 16, top: 8, bottom: 8, right: 16),
                    decoration: BoxDecoration(
                        color: AppConstants.whiteColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(diagnosis.data!.clinicalSummary ?? '',
                        style: AppConstants.subLabelLightTextStyle(
                            FontWeight.w500, AppConstants.subLabelColor)),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
