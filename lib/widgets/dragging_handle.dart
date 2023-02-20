import 'package:flutter/material.dart';

class DraggingHandle extends StatelessWidget {
  const DraggingHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(16)),
    );
  }
}
