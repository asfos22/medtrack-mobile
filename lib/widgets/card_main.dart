import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/repository/utils/helper.dart';

class CardMain extends StatelessWidget {
  //final ImageProvider ?image;
  final String title;
  final String? description;
  final Color? color;

  const CardMain(
      {Key? key,
      //this.image,
      required this.title,
      this.description,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Helper.getScreenWidth(context),
      // height: ((Helper.getScreenWidth(context) - (AppConstants.paddingSide * 2 + AppConstants.paddingSide / 2)) / 2),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: AppConstants.borderLineColor),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock, color: AppConstants.greenColor),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),

            title: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child:

            Text(
              title,

              style: TextStyle(
                  color: AppConstants.blackColor,
                  fontSize: 22,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold),
            )),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Text(description!,
                style: TextStyle(
                    color: AppConstants.subLabelColor,
                    fontSize: 14,
                    fontFamily: 'Roboto')),
          )
          // trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0))
        ],
      ),
    );
  }
}
