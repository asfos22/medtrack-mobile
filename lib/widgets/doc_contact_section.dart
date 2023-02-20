import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

import 'horizontal_line.dart';

class DocContactSection extends StatelessWidget {
  const DocContactSection(
      {Key? key,
      this.icon,
      this.title,
      this.subTitle,
      this.backGroundColor,
      this.trailing,
      this.onTab})
      : super(key: key);

  final IconData? icon;
  final String? title;
  final String? subTitle;
  final Color? backGroundColor;
  final Widget? trailing;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon != null
              ? ListTile(
                  leading: icon != null
                      ? Icon(icon, color: AppConstants.greyColor)
                      : Container(
                          width: 1,
                        ),
                  title: Text(title!,
                      style: AppConstants.subLabelLightTextStyle(
                          FontWeight.w700, AppConstants.subLabelColor)),
                  subtitle:
                      Text(subTitle!, style: AppConstants.h2HeadingTextStyle),
                  trailing: trailing ??
                      Container(
                        width: 16,
                      ),
                  onTap: onTab,
                )
              : ListTile(
                  title: Text(title!,
                      style: AppConstants.subLabelLightTextStyle(
                          FontWeight.w700, AppConstants.subLabelColor)),
                  subtitle:
                      Text(subTitle!, style: AppConstants.h2HeadingTextStyle),
                  trailing: trailing ?? Container(width: 16),
                  onTap: onTab,
                ),
          Container(
            margin: const EdgeInsets.only(left: 64),
            child: const HorizontalLine(height: 0.9),
          ),
        ],
      ),
    );
  }
}
