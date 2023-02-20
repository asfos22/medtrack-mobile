import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';

class CustomSettingsDefaultAppBar extends StatefulWidget {
  const CustomSettingsDefaultAppBar(
      {Key? key,
      //this.icon,
      required this.title,
      required this.subTitle,
      this.textColor,
      this.backgroundColor})
      : super(key: key);

  final String title;
  final Widget? subTitle;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  _CustomSettingsDefaultAppBarState createState() =>
      _CustomSettingsDefaultAppBarState();
}

class _CustomSettingsDefaultAppBarState
    extends State<CustomSettingsDefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: widget.backgroundColor ?? AppConstants.backgroundColor,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: widget.textColor ?? AppConstants.whiteColor,
          ),
          onPressed: () {
            Helper.dismissDialog(context);
          }),
      bottom: PreferredSize(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 16.0),
            child: ListTile(
                title: Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.textColor ?? AppConstants.whiteColor,
                    fontSize: 26,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: widget.subTitle)),
        preferredSize: const Size(0.0, 80.0),
      ),
    );
  }
}
