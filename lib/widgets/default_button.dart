import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key, this.text, this.press, this.backGroundColor, this.textColor})
      : super(key: key);
  final String? text;
  final Function()? press;
  final Color? backGroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.all(0),
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backGroundColor ?? AppConstants.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text!,
          style: AppConstants.subLabelLightTextStyle(
              FontWeight.w700,
              textColor ??
                  AppConstants
                      .whiteColor) /*TextStyle(
              color: textColor ?? AppConstants.whiteColor, fontSize: 16.0)*/
          ,
        ),
      ),
    );
  }
}
