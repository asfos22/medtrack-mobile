import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/custom_app_bar.dart';
import 'package:medtrack/widgets/empty_state_card.dart';
import 'package:medtrack/widgets/empty_state_header_card.dart';

class ClinicalEmptyScreen extends StatefulWidget {
  const ClinicalEmptyScreen({Key? key}) : super(key: key);

  @override
  _ClinicalEmptyScreenState createState() => _ClinicalEmptyScreenState();
}

class _ClinicalEmptyScreenState extends State<ClinicalEmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size(
                double.infinity, AppConstants.defaultAppBarSizeHeight),
            child: CustomAppBar(
              title: "Clinical Visit",
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
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  height: 45,
                  width: Helper.getScreenWidth(context),
                  decoration: BoxDecoration(
                      color: AppConstants.whiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      EmptyStateHeaderCard(
                          backgroundColor: AppConstants.lineColor),
                      const SizedBox(width: 32),
                      EmptyStateHeaderCard(
                          backgroundColor: AppConstants.lineColor),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                  margin: const EdgeInsets.all(16.0),
                  child: _mainContainer(),
                )
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
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              child: Container(
                height: 84,
                width: 84,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConstants.borderLineColor,
                ),
              ),
            ),
            Positioned(
              top: -10,
              left: 20,
              bottom: -42,
              child: Container(
                height: 50,
                width: 110,
                margin: const EdgeInsets.all(0),
                child: SvgPicture.asset(
                  Helper.getAssetSVGName("iconDarkId", "svg"),
                  color: AppConstants.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
      headerLabel: 'Empty Folder\n State Title',
      subLabel:
          'Describe how this will help user track prescribed medications.',
      onTap: () => {},
    );
  }
}
