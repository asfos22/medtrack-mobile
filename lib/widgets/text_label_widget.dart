import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class TextLabel extends StatelessWidget {
  const TextLabel({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      child: Text(text,
          style: TextStyle(
              color: AppConstants.blackColor,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal)),
    );
  }
}
