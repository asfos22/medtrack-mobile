import 'package:flutter/material.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/models/notification/notification_settings_model.dart';
import 'package:medtrack/widgets/switch_widget.dart';

class NotificationSwitchListTile extends StatefulWidget {
  final NotificationItem notificationItem;
  final bool isSelected;

  const NotificationSwitchListTile(
      {Key? key, required this.notificationItem, required this.isSelected})
      : super(key: key);

  @override
  _NotificationSwitchListTileState createState() =>
      _NotificationSwitchListTileState();
}

class _NotificationSwitchListTileState
    extends State<NotificationSwitchListTile> {
  bool _isSelected = false;
  var selectedIndexes = [];
  AuthModel authModel = AuthModel();
  List<int> selectedNotification = <int>[];

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      _isSelected = widget.isSelected;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchWidget(
      switchControl: _isSelected,
      onChanged: (value) => setState(() {
        _isSelected = value;

        int selectedID = widget.notificationItem
            .id!; //json.encode(widget.notificationItem.id.toString());

        if (value == true) {
          if (authModel.selectedNotification.contains(selectedID)) {
            authModel.selectedNotification.remove(selectedID);
          }
          authModel.selectedNotification.add(selectedID);
        } else {
          if (authModel.selectedNotification.contains(selectedID)) {
            authModel.selectedNotification.remove(selectedID);
          }
        }
      }),
      notificationItem: widget.notificationItem,
    );
  }
}
