import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/dashboard/screens/dashboard/clinical_visits/clinical_visits_screen.dart';
import 'package:medtrack/dashboard/screens/dashboard/encounter_actions/diagnostic_screen.dart';
import 'package:medtrack/dashboard/screens/dashboard/prescriptions_list/prescription_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/horizontal_line.dart';
import 'package:medtrack/widgets/text_button_widget.dart';

class HomeMainCard extends StatefulWidget {
  final Item item;

  const HomeMainCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<HomeMainCard> createState() => _HomeMainCardState();
}

class _HomeMainCardState extends State<HomeMainCard> {
  late bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0.0),
      margin: const EdgeInsets.symmetric(vertical: 0.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(0.0)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                left: 16.0, top: 8.0, bottom: 8.0, right: 16.0),
            margin: const EdgeInsets.symmetric(vertical: 0.0),
            decoration: BoxDecoration(
                color: AppConstants.backgroundColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(0.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          SvgPicture.asset(
                              Helper.getAssetSVGName("accessBadge", "svg")),
                          const SizedBox(width: 16),
                          Text(
                            "Access Control",
                            style: AppConstants.h2HeadingTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      InkWell(
                        onTap: () {
                          Helper.dismissDialog(context);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.whiteColor,
                            border: Border.all(
                                color: AppConstants.whiteColor, width: 3.0),
                          ),
                          child: Icon(Icons.close,
                              size: 16, color: AppConstants.blackColor),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: ListTile(
              title: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    child: SvgPicture.asset(Helper.getAssetSVGName("", "svg")),
                    backgroundColor: AppConstants.whiteColor.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppConstants.docTitle.toUpperCase(),
                          style: AppConstants.subLabelLightTextStyle(
                              FontWeight.w700, AppConstants.subLabelColor)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(AppConstants.docName2,
                          style: AppConstants.h2HeadingTextStyle),
                    ],
                  )
                ],
              )),
              // subtitle:  Center(child: Text("My title is centered")),
            ),
          ),
          const SizedBox(height: 16),
          const HorizontalLine(height: 1),
          const SizedBox(height: 8),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Facility".toUpperCase(),
                  style: AppConstants.h4SecondaryLabelLightTextStyle),
              const SizedBox(
                width: 16,
              ),
              Text("DL Hospital", style: AppConstants.h2HeadingTextStyle),
            ],
          )),
          const SizedBox(height: 8),
          const HorizontalLine(height: 1),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isVisible == false
                  ? Column(
                      children: [
                        Text("Tap to confirm access",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppConstants.subLabelColor)),
                        const SizedBox(height: 16.0),
                        TextButtonWidget(
                          onPressed: () {
                            setState(() {
                              isVisible = true;
                            });
                          },
                        )
                      ],
                    )
                  : Column(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            routeSwitch(widget.item);
                          },
                          child: Icon(Icons.check,
                              size: 42, color: AppConstants.greenColor),
                          style: OutlinedButton.styleFrom(
                            shape: const CircleBorder(),
                            side: BorderSide(
                                width: 2.0, color: AppConstants.greenColor),
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text("Access Granted",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppConstants.subLabelColor)),
                      ],
                    )
            ],
          ),
        ],
      ),
    );
  }

  void routeSwitch(Item item) {
    switch (item.code) {
      case AppConstants.catPrescription:
        Helper.navigateToNextPage(
            context, PrescriptionScreen(prescription: item.prescription));

        break;
      case AppConstants.catClinical:
        //  Helper.navigateToNextPage(context, const EncounterExaminationsScreen());
        Helper.navigateToNextPage(
            context,
            ClinicalVisitScreen(
                clinicalVisits: item.clinicalVisits!,
                visitsDetails: item.visitsDetails ?? []
                //diagnosisReports: item.diagnosisReports ?? [],
                ));

        break;
      case AppConstants.catDiagnosis:
        //Helper.navigateToNextPage(context, const PrescriptionScreen());

        // Helper.navigateToNextPage(context, const EncounterExaminationsScreen());
        Helper.navigateToNextPage(
            context,
            DiagnosticScreen(
              diagnosisReport: item.diagnosisReports,
            ));

        //Helper.navigateToNextPage(
        //   context, EncounterExaminationsScreen(diagnosis: item.diagnosis!));
        // Helper.navigateToNextPage(
        //    context, ClinicalVisitPage(clinicalVisits: item.clinicalVisits!));

        break;
      case AppConstants.catHealthData:
        //Helper.navigateToNextPage(context, const HealthDataScreen());

        break;
      default:
        Helper.navigateToNextPage(
            context, PrescriptionScreen(prescription: item.prescription));
    }
  }
}
