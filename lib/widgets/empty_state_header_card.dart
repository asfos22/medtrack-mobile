import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class EmptyStateHeaderCard extends StatelessWidget {
  final Color? backgroundColor;

  const EmptyStateHeaderCard({Key? key, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      height: 45,
      decoration: BoxDecoration(
          color: AppConstants.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor ?? AppConstants.lineColor)),
            onTap: () {},
          ),
          GestureDetector(
            child: Container(
                height: 24,
                width: 80,
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor ?? AppConstants.lineColor)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
