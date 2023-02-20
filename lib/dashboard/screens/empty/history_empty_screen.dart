import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/doc_section.dart';
import 'package:medtrack/widgets/empty_state_card.dart';

class HistoryEmptyScreen extends StatefulWidget {
  const HistoryEmptyScreen({Key? key}) : super(key: key);

  @override
  _HistoryEmptyScreenState createState() => _HistoryEmptyScreenState();
}

class _HistoryEmptyScreenState extends State<HistoryEmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "History & Exam...",
              subTitle: Container(),
              textColor: AppConstants.whiteColor,
              backgroundColor: AppConstants.primaryColor,
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppConstants.whiteColor),
                    child: DocSection(
                      icon: SvgPicture.asset(
                          Helper.getAssetSVGName("iconDarkPerson", "svg")),
                      title: AppConstants.docTitle,
                      subTitle: AppConstants.docName,
                      trailing: const Padding(
                        padding: EdgeInsets.only(
                            left: 8, top: 4.0, right: 4.0, bottom: 8.0),
                        child: Icon(Icons.more_horiz),
                      ),
                      date: AppConstants.docDate,
                      time: AppConstants.docTime,
                    )),
                Container(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                    width: double.infinity,
                    child: _mainContainer())
              ],
            ),
          ),
        ));
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
      headerLabel: 'Empty Examination State Title',
      subLabel: 'Prescriptions from your clinical visits will appear here.',
      onTap: () => {},
    );
  }
}
