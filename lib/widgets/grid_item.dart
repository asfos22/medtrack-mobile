import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/dashboard/screens/dashboard/health_data/health_data_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';

import 'home_main_card.dart';

class GridItem extends StatelessWidget {
  final SvgPicture? icon;
  final String title;
  final String description;
  final Item item;

  //final ImageProvider? image;
  final Color color;

  const GridItem({
    Key? key,
    this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          AuthModel authModel = AuthModel();

          if (item.code == AppConstants.catHealthData) {
            Helper.navigateToNextPage(
                context, HealthDataScreen(authModel: authModel));
          } else {
            Helper.showActionModalBottomSheet(
                context, false, HomeMainCard(item: item));
          }
        },
        child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              shape: BoxShape.rectangle,
              color: AppConstants.backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppConstants.whiteColor,
                  radius: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: icon!,
                    color: AppConstants.whiteColor,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.blackColor),
                ),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14, color: AppConstants.subLabelColor),
                )
              ],
            )));
  }
}
