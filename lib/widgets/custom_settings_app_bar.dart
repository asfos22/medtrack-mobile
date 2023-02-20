import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';


class CustomSettingsAppBar extends StatefulWidget {
  const CustomSettingsAppBar(
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
  _CustomSettingsAppBarState createState() => _CustomSettingsAppBarState();
}

class _CustomSettingsAppBarState extends State<CustomSettingsAppBar> {
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
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(top: 8.0, bottom: 24.0, right: 8.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.textColor ?? AppConstants.whiteColor,
                      fontSize: 26,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                widget.subTitle!
              ],
            )),
        preferredSize: const Size(0.0, 80.0),
      ),
    );
  }
}
