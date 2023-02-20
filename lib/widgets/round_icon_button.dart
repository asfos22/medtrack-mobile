import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        size: 45,
        color: Colors.white,
      ),
      onPressed: onPressed,
      elevation: 0.0,
      constraints: const BoxConstraints.tightFor(
        width: 76.0,
        height: 76.0,
      ),
      shape: const CircleBorder(),
      fillColor: Colors.lightGreenAccent,
    );
  }
}
