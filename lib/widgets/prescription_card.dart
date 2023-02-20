import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/screens/empty/clinical_empty_screen.dart';
import 'package:medtrack/dashboard/screens/empty/prescription_empty_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';

import 'default_button.dart';
import 'doc_contact_section.dart';

class PrescriptionCard extends StatelessWidget {
  final String _header;
  final String _title;
  final String _description;
  final Color _bgColor;
  final bool isDetails;
  final String? _facilityTitle;
  final String? _facilityDescription;

  const PrescriptionCard(
      this._header,
      this._title,
      this._description,
      this._bgColor,
      this.isDetails,
      this._facilityTitle,
      this._facilityDescription,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DecoratedBox(
              decoration: BoxDecoration(
                color: _bgColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: AppConstants.backgroundColor,
                  ),
                  title: Text(
                    _title,
                    style: AppConstants.subLabelLightTextStyle(
                        FontWeight.w700, AppConstants.subLabelColor),
                  ),
                  subtitle: Text(_description,
                      style: AppConstants.h2HeadingTextStyle),
                  trailing: GestureDetector(
                    child: CircleAvatar(
                      radius: 14.0,
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 12,
                      ),
                      backgroundColor: AppConstants.whiteColor,
                    ),
                    onTap: () {
                      Helper.dismissDialog(context);
                    },

                    //const Icon(Icons.close),
                  ),
                ),
              )),
          Container(
              margin: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  _facilityTitle!.isNotEmpty && _facilityDescription!.isNotEmpty
                      ? DocContactSection(
                          icon: Icons.apartment_rounded,
                          title: _facilityTitle!,
                          subTitle: _facilityDescription!,
                          // trailing: Icon(Icons.arrow_forward_ios_outlined),
                        )
                      : Container(),
                  const DocContactSection(
                    icon: Icons.call,
                    title: "Phone Number",
                    subTitle: "+233028263632",
                    // trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  const DocContactSection(
                    icon: Icons.email_outlined,
                    title: "Email",
                    subTitle: "facilityname@domain.com",
                    // trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  const DocContactSection(
                    icon: Icons.location_pin,
                    title: "Location",
                    subTitle: "Weija,Accra,Ghana",
                    // trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  SingleChildScrollView(
                    child: Container(
                        margin: const EdgeInsets.only(
                            left: 16.0, top: 12.0, right: 16.0),
                        child: Column(children: [
                          isDetails == true
                              ? Container(
                                  width: Helper.getScreenWidth(context),
                                  margin: const EdgeInsets.all(0.0),
                                  padding: const EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppConstants.borderLineColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: DefaultButton(
                                    text: "View Visit Details",
                                    backGroundColor: AppConstants.whiteColor
                                        .withOpacity(0.9),
                                    textColor: AppConstants.blackColor,
                                    press: () {
                                      Helper.navigateToNextPage(context,  PrescriptionEmptyScreen(prescription:null));
                                    },
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: 16,
                          ),
                          DefaultButton(
                            text: _header,
                            backGroundColor: AppConstants.primaryColor,
                            textColor: AppConstants.whiteColor,
                            press: () {
                              Helper.navigateToNextPage(
                                  context, const ClinicalEmptyScreen());
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ])),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
