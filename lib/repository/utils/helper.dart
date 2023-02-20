import 'package:flutter/material.dart';

class Helper {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static String getAssetName(String fileName, String type) {
    return "assets/images/$type/$fileName";
  }

  static String getAssetSVGName(String fileName, String type) {
    return "assets/svg/$fileName.$type";
  }

  static void navigateToNextPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }),
    );
  }

  static void dismissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showActionModalBottomSheet(
      BuildContext context, bool isScrollControlled, Widget page) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        isDismissible: true,
        builder: (builder) {
          return page;
        });
  }
}
