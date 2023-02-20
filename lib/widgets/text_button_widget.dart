import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({Key? key,
    this.onPressed,
  }) : super(key: key);
  
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.only(left:16, top: 8.0, right: 16.0, bottom: 8.0),
        child: Text('Grant Access',
            style: TextStyle(
                color: AppConstants.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
      ),
      style: TextButton.styleFrom(
        primary: AppConstants.greenColor,
        onSurface: AppConstants.greenColor,
        backgroundColor: AppConstants.greenColor,
        side: BorderSide(color: AppConstants.greenColor, width: 4),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
      onPressed: onPressed
    );
  }
}
