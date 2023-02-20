import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/grid_item.dart';

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, this.item}) : super(key: key);
  final Item? item;

  @override
  Widget build(BuildContext context) {
    return GridItem(
      icon: SvgPicture.asset(Helper.getAssetSVGName(item!.icon!, "svg")),
      title: item!.title!,
      description: item!.description!,
      color: AppConstants.blackColor,
      item: item!,
    );
  }
}
