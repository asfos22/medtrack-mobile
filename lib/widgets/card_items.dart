import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/horizontal_line.dart';


class CardItems extends StatelessWidget {
  final SvgPicture? icon;
  final String title;
  final String? subTitle;
  final Color? lineColor;

  const CardItems({
    Key? key,
    this.icon,
    required this.title,
    this.subTitle,
    this.lineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, bottom: 18, right: 24),
      decoration: BoxDecoration(
        color: AppConstants.artBoardBackground,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        shape: BoxShape.rectangle,
      ),
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                decoration: BoxDecoration(
                  //borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: lineColor,
                ),
                height: 0.8,
                width: Helper.getScreenWidth(context),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // svg Icon

                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 15, color: AppConstants.blackColor),
                    ),
                    const SizedBox(width: 16),
                    const HorizontalLine(height: 1),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      subTitle ?? '',
                      style: TextStyle(
                          fontSize: 15, color: AppConstants.blackColor),
                    ),
                    const SizedBox(width: 8.0),
                    const HorizontalLine(height: 1),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                decoration: BoxDecoration(
                  //borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: lineColor,
                ),
                height: 0.8,
                width: Helper.getScreenWidth(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}
