import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class ListTileDefaultWidget extends StatelessWidget {
  const ListTileDefaultWidget(
      {Key? key,
      this.title,
      this.subTitle,
      this.backGroundColor,
      this.textColor,
      required this.onTab})
      : super(key: key);
  final String? title;
  final Widget? subTitle;
  final Color? backGroundColor;
  final Color? textColor;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:title!=null?Text(title??'', style: AppConstants.h2HeadingTextStyle):Container(),
      subtitle: subTitle,
      onTap: onTab,
    );
  }
}
