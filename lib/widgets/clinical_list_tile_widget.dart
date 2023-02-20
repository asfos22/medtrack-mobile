import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';

class ClinicalListTileWidget extends StatelessWidget {
  const ClinicalListTileWidget(
      {Key? key,
      this.icon,
      this.title,
      this.subTitle,
      this.description,
      this.backGroundColor,
      this.textColor,
      required this.onTab,
      this.isTrail})
      : super(key: key);

  final SvgPicture? icon;
  final String? title;
  final String? subTitle;
  final String? description;
  final Color? backGroundColor;
  final Color? textColor;
  final VoidCallback onTab;
  final bool? isTrail;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Helper.getScreenWidth(context),
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            description != null
                ? Column(
                    children: [
                      Text(description ?? '',
                          style: AppConstants.subLabelLightTextStyle(
                              FontWeight.w700, AppConstants.blackColor)),
                    ],
                  )
                : Container(),
            ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                child: icon,
                backgroundColor: backGroundColor!,
              ),
              title: Text(
                title!,
                style: AppConstants.subLabelLightTextStyle(
                    FontWeight.w700, AppConstants.blackColor),
              ),
              subtitle: Text(
                subTitle!,
                style: AppConstants.subLabelLightTextStyle(
                    FontWeight.w500, AppConstants.subLabelColor),
              ),
              trailing: isTrail == true
                  ? const Icon(Icons.arrow_forward_ios_outlined)
                  : Container(width: 16),
              onTap: onTab,
            )
          ],
        ));
  }
}
