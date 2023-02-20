import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/notification/notification_settings_model.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget(
      {Key? key,
      required this.notificationItem,
      required this.onChanged,
      required this.switchControl})
      : super(key: key);

  final Function(bool) onChanged;

  final bool switchControl;
  final NotificationItem notificationItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Transform.scale(
          scale: 1.2,
          child: SwitchListTile(
            title: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  notificationItem.title ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  notificationItem.description ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            value: switchControl,
            onChanged: onChanged,
            activeColor: AppConstants.greenColor,
            activeTrackColor: AppConstants.borderLineColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          ) /*Switch(
          onChanged: toggleSwitch,
          value: switchControl,
          activeColor: AppConstants.greenColor,
          activeTrackColor: AppConstants.borderLineColor,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey,
        )*/
          ),
    );
  }
}
