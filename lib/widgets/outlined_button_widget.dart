import 'package:flutter/material.dart';

class OutLinedButtonWidget extends StatelessWidget {
  const OutLinedButtonWidget({
    Key? key,
    this.icon,
    this.borderColor,
    this.backGroundColor,
  }) : super(key: key);

  final Icon? icon;
  final Color? backGroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: icon ?? Container(),
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        side: BorderSide(width: 2.0, color: borderColor!),
        backgroundColor: backGroundColor,
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}
