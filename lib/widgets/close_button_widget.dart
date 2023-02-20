import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget(
      {Key? key,
      required this.backGroundColor,
      required this.iconColor,
      required this.onTab})
      : super(key: key);

  final Color backGroundColor;
  final Color iconColor;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backGroundColor,
        ),
        child: Icon(Icons.close, size: 16, color: iconColor),
        alignment: Alignment.center,
      ),
    );
  }
}
