import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medtrack/constants/app_constants.dart';

import 'horizontal_line.dart';

class DocSection extends StatelessWidget {
  const DocSection(
      {Key? key,
      this.icon,
      this.title,
      this.subTitle,
      this.backGroundColor,
      this.textColor,
      this.date,
      this.time,
      this.trailing,
      this.onTab})
      : super(key: key);

  final SvgPicture? icon;
  final String? title;
  final String? subTitle;
  final Color? backGroundColor;
  final Color? textColor;
  final String? date;
  final String? time;
  final Widget? trailing;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null
              ? ListTile(
                  leading: icon != null
                      ? CircleAvatar(
                          radius: 30.0,
                          child: icon,
                          backgroundColor: AppConstants.artBoardBackground,
                        )
                      : Container(
                          width: 16,
                        ),
                  title: Text(
                    title!,
                    style: AppConstants.subLabelLightTextStyle(
                        FontWeight.w700, AppConstants.subLabelColor),
                  ),
                  subtitle:
                      Text(subTitle!, style: AppConstants.h2HeadingTextStyle),
                  trailing: trailing ??
                      Container(
                        width: 16,
                      ),
                  onTap: onTab,
                )
              : ListTile(
                  title: Text(
                    title!,
                    style: AppConstants.subLabelLightTextStyle(
                        FontWeight.w700, AppConstants.subLabelColor),
                  ),
                  subtitle:
                      Text(subTitle!, style: AppConstants.h2HeadingTextStyle),
                  trailing: trailing ?? Container(width: 16),
                  onTap: onTab,
                ),
          const HorizontalLine(height: 1),
          Container(
              margin: const EdgeInsets.only(
                  left: 90, right: 16, top: 8.0, bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.date_range,
                    size: 16,
                    color: AppConstants.subLabelColor,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    date!,
                    textAlign: TextAlign.center,
                    style: AppConstants.subLabelLightTextStyle(
                        FontWeight.w500, AppConstants.subLabelColor),
                  ),
                  const SizedBox(width: 32),
                  Icon(
                    Icons.access_time_outlined,
                    size: 14,
                    color: AppConstants.subLabelColor,
                  ),
                  const SizedBox(width: 8.0),
                  Text(time!,
                      style: AppConstants.subLabelLightTextStyle(
                          FontWeight.w500, AppConstants.subLabelColor))
                ],
              )),
         // const HorizontalLine(height: 0),
        ],
      ),
    );
  }
}
