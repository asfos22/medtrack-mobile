import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class EmptyStateCard extends StatelessWidget {
  final Widget? icon;
  final String? headerLabel;
  final String? subLabel;
  final VoidCallback? onTap;

  const EmptyStateCard(
      {Key? key,
      this.icon,
      required this.headerLabel,
      this.subLabel,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          icon!,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(headerLabel!,
                  textAlign: TextAlign.center,
                  style: AppConstants.h1HeadingTextStyle),
              const SizedBox(height: 16),
              Text(
                subLabel!,
                textAlign: TextAlign.center,
                style: AppConstants.bodyCopyLightTextStyle,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                height: 45,
                width: 124,
                decoration: BoxDecoration(
                    color: AppConstants.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        child: Container(
                            height: 24,
                            //width: 26,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Center(
                              child: Text(
                                "Action",
                                style: TextStyle(
                                    color: AppConstants.whiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            )),
                        onTap: onTap),
                    GestureDetector(
                      child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppConstants.blackColor)),
                      onTap: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
