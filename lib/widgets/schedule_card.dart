import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class ScheduleCard extends StatelessWidget {
  final String _title;
  final String _description;
  final String _date;
  final String _month;
  final Color _bgColor;
  final Widget ?trailingIcon;

  const ScheduleCard(
      this._title, this._description, this._date, this._month, this._bgColor, this.trailingIcon,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _bgColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            /*decoration: BoxDecoration(
              color: _bgColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),*/
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _date,
                  style: TextStyle(
                    color: _bgColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _month,
                  style: TextStyle(
                    color: AppConstants.subLabelColor.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            _title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppConstants.subLabelColor.withOpacity(0.7),
            ),
          ),
          subtitle: Text(
            _description,
            style: AppConstants.h2HeadingTextStyle,
          ),
          trailing: trailingIcon,
        ),
      ),
    );
  }
}
