import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/close_button_widget.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard(
      {Key? key,
      //this.icon,
      required this.title,
      this.textColor,
      this.backgroundColor})
      : super(key: key);

  final String title;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        color: widget.backgroundColor ?? AppConstants.greenColor,
        margin: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(4.0),
              child: ListTile(
                title: Column(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      color: AppConstants.whiteColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.textColor ??
                            AppConstants.whiteColor.withOpacity(0.6),
                      ),
                    )
                  ],
                ),
                trailing: CloseButtonWidget(
                  backGroundColor: AppConstants.blackColor.withOpacity(0.4),
                  iconColor: AppConstants.whiteColor,
                  onTab: () => Helper.dismissDialog(context),
                ),
              ),
            ),
          ],
        ),
      ),
      preferredSize: const Size(0.0, 80.0),
    );
  }
}
