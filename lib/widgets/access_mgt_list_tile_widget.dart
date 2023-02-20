import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';

class AccessMgtListTileWidget extends StatelessWidget {
  const AccessMgtListTileWidget(
      {Key? key,
      this.icon,
      this.title,
      this.subTitle,
      this.backGroundColor,
      this.textColor,
      this.trailing,
      this.onTab})
      : super(key: key);

  final SvgPicture? icon;
  final Widget? title;
  final String? subTitle;
  final Color? backGroundColor;
  final Color? textColor;
  final Widget? trailing;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            left: 16.0, right: 0.0, top: 2.0, bottom: 2.0),
        width: Helper.getScreenWidth(context),
        decoration: BoxDecoration(
          color: backGroundColor,
          /* border: Border.all(
              color: AppConstants.borderLineColor,
            )*/
        ),
        child: icon != null
            ? ListTile(
                leading: icon != null
                    ? CircleAvatar(
                        radius: 18.0,
                        child: icon,
                        backgroundColor: AppConstants.artBoardBackground,
                      )
                    : Container(
                        width: 1,
                      ),
                title: title ?? Container(width: 16),
                subtitle: Text(subTitle!,
                    style: AppConstants.h4SecondaryLabelLightTextStyle),
                trailing: trailing ??
                    Container(
                      width: 16,
                    ),
                onTap: onTab,
              )
            : ListTile(
                title: title,
                subtitle: Text(subTitle!),
                trailing: trailing ?? Container(width: 16),
                onTap: onTab,
              ));
  }
}
