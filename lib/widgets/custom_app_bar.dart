import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
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
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: backgroundColor ?? AppConstants.backgroundColor,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textColor ?? AppConstants.whiteColor,
          ),
          onPressed: () {
            Helper.dismissDialog(context);
          }),
      actions: <Widget>[
        GestureDetector(
            onTap: () {
              //do what hey Joel what want here
            },
            child: Container(
              margin: const EdgeInsets.only(top: 8.0, right: 8.0),
              child: CircleAvatar(
                radius: 32.0,
                backgroundImage:
                    const NetworkImage('https://via.placeholder.com/150'),
                backgroundColor: AppConstants.backgroundColor,
              ),
            ))
      ],
      bottom: PreferredSize(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
            child: ListTile(
                title: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: textColor ?? AppConstants.whiteColor,
                    fontSize: 34,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: subTitle)),
        preferredSize: const Size(0.0, 80.0),
      ),
    );
  }
}
