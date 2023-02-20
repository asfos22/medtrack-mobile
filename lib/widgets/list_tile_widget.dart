import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: unused_import
import 'package:medtrack/constants/app_constants.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget(
      {Key? key,
      this.icon,
      this.title,
      this.subTitle,
      this.backGroundColor,
      this.textColor,
      required this.onTab,
      this.trailingIcon})
      : super(key: key);

  final SvgPicture? icon;
  final String? title;
  final String? subTitle;
  final Color? backGroundColor;
  final Color? textColor;
  final VoidCallback onTab;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        child: icon,
        backgroundColor: backGroundColor,
      ),
      title: Text(
        title!,
        style: AppConstants.h2HeadingTextStyle,
      ),
      subtitle: Text(
        subTitle!,
        style: AppConstants.subLabelLightTextStyle(
            FontWeight.w500, AppConstants.subLabelColor),
      ),
      trailing: Icon(trailingIcon, size: 16, color: AppConstants.greyColor,),
      onTap: onTab,
    );
  }
}
