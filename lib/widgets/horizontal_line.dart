import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medtrack/constants/app_constants.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: height, color: AppConstants.lineColor.withOpacity(0.6)),
        ),
      ),
    );
  }
}
