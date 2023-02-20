import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/access_mgt_list_tile_widget.dart';
import 'package:medtrack/widgets/close_button_widget.dart';
import 'package:medtrack/widgets/custom_background_container.dart';
import 'package:medtrack/widgets/default_button.dart';
import 'package:medtrack/widgets/horizontal_line.dart';
import 'package:medtrack/widgets/prescription_card.dart';

class AccessControlExpandedScreen extends StatefulWidget {
  final List<AccessControl?>? accessControl;

  const AccessControlExpandedScreen({Key? key, this.accessControl})
      : super(key: key);

  @override
  _ClinicalVisitEmptyScreenState createState() =>
      _ClinicalVisitEmptyScreenState();
}

class _ClinicalVisitEmptyScreenState
    extends State<AccessControlExpandedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
            child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    // Helper.navigateToNextPage(context,  ClinicalAccessControlScreen(clinicalVisits:widget. clinicalVisits));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 32),
                              margin: const EdgeInsets.all(16.0),
                              child: CloseButtonWidget(
                                backGroundColor:
                                    AppConstants.whiteColor.withOpacity(0.4),
                                iconColor: AppConstants.subLabelColor,
                                onTab: () => Helper.dismissDialog(context),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: const Text(
                                "Access Control",
                                style: TextStyle(
                                    fontSize: 34,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const HorizontalLine(height: 1),
                        AccessMgtListTileWidget(
                          icon: SvgPicture.asset(
                              Helper.getAssetSVGName("accessBadge", "svg")),
                          title: const Text("Physician Access"),
                          subTitle: "Revoke physician access to this session",
                          backGroundColor: Colors.grey.shade300,
                        ),
                        Container(
                            width: Helper.getScreenWidth(context),
                            padding: const EdgeInsets.all(0.0),
                            margin: const EdgeInsets.only(left: 0, right: 0.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.accessControl!.length,
                                itemBuilder: (context, index) {
                                  return mainItem(widget.accessControl![
                                      index]!); //mainItem(notifications[index]);
                                }))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(16.0),
                child: DefaultButton(
                  text: "Done",
                  backGroundColor: AppConstants.primaryColor,
                  textColor: AppConstants.whiteColor,
                  press: () {},
                ),
              ),
            ),
          ],
        )));
  }

  mainItem(AccessControl control) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      physics: const AlwaysScrollableScrollPhysics(),
      children: control.physicians!
          .map((item) => Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: AccessMgtListTileWidget(
                        icon: SvgPicture.asset(
                            Helper.getAssetSVGName("iconDarkPerson", "svg")),
                        title: item.primary != null
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      item.name!,
                                      style: AppConstants.h2HeadingTextStyle,
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(width: 4),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: item.primary != null
                                        ? CustomBackgroundContainer(
                                            content: Text(
                                              item.primary ?? '',
                                              style: TextStyle(
                                                  color: item.isRevoke == false
                                                      ? AppConstants.greyColor
                                                      : AppConstants.greyColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            backGroundColor:
                                                AppConstants.greyColor,
                                            height: 24,
                                            width: 64,
                                          )
                                        : Container(),
                                  ),
                                ],
                              )
                            : Text(item.name!,
                                style: AppConstants.h2HeadingTextStyle),

                        //  item.name,
                        subTitle: item.facilityName,
                        trailing: TextButton(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, top: 4.0, right: 4.0, bottom: 8.0),
                            child: Text(item.revoke!,
                                style: TextStyle(
                                    color: item.isRevoke == false
                                        ? AppConstants.whiteColor
                                        : AppConstants.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ),
                          style: TextButton.styleFrom(
                            primary: item.isRevoke == false
                                ? AppConstants.colorRed
                                : AppConstants.greyColor.withOpacity(0.5),
                            onSurface: item.isRevoke == false
                                ? AppConstants.colorRed
                                : AppConstants.greyColor.withOpacity(0.5),
                            backgroundColor: item.isRevoke == false
                                ? AppConstants.colorRed
                                : Colors.grey.shade200,
                            fixedSize: const Size(85, 42),
                            side: BorderSide(
                                color: item.isRevoke == false
                                    ? AppConstants.colorRed
                                    : Colors.grey.shade200,
                                width: 1),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                          ),
                          onPressed: () {
                            Helper.showActionModalBottomSheet(
                                context,
                                false,
                                PrescriptionCard(
                                    "Done",
                                    AppConstants.docTitle,
                                    item.name!,
                                    AppConstants.subLabelColor,
                                    false,
                                    item.contact!.facility,
                                    item.contact!.location!));
                          },
                        ),
                        backGroundColor: AppConstants.whiteColor,
                      )),
                  const HorizontalLine(height: 1),
                ],
              ))
          .toList(),
    );
  }
}
