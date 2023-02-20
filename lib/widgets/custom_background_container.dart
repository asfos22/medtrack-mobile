import 'package:flutter/material.dart';

class CustomBackgroundContainer extends StatelessWidget {
  const CustomBackgroundContainer(
      {Key? key, this.content, this.backGroundColor, this.width, this.height})
      : super(key: key);
  final Widget? content;
  final Color? backGroundColor;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(2),
      height: height ?? 24,
      width: width ?? 64,
      decoration: BoxDecoration(
        color: backGroundColor!.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: content ?? Container(width: 16),
    );
  }
}
