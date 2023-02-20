import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/item.dart';

class DropDown extends StatelessWidget {
  final GlobalKey? fbKey;
  final String? labelText;
  final List<Item>? itemsList;
  final Function(dynamic) onChanged;

  const DropDown(
      {Key? key,
      @required this.fbKey,
      this.labelText,
      this.itemsList,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 55,
        decoration: BoxDecoration(
          color: AppConstants.lineColor,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Center(
            child: DropdownButtonHideUnderline(
          child: DropdownButton<Item>(
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              color: AppConstants.textEditBackground,
            ),
            // iconSize: 22,
            elevation: 2,
            style: TextStyle(color: AppConstants.blackColor),
            isDense: true,
            isExpanded: true,
            hint: Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 30),
              child: Text(labelText!, style: const TextStyle(fontSize: 16)),
            ),
            onChanged: onChanged,
            items: itemsList!.map((Item item) {
              return DropdownMenuItem<Item>(
                value: item,
                child: Text(item.value!),
              );
            }).toList(),
          ),
        )));
  }
}
