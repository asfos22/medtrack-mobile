import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

class PinInputField extends StatelessWidget {
  final Color? color, placeholderColor;
  final String? placeholder;

  const PinInputField(
      {Key? key, this.color, this.placeholder, this.placeholderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;

    return Center(
      child: Transform(
        transform:
            Matrix4.translation(Provider.of<vector_math.Vector3>(context)),
        child: Center(
          child: TextField(
            enabled: false,
            obscureText: true,
            controller: Provider.of<TextEditingController>(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: width / 8,
              letterSpacing: 1,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: TextStyle(
                    color: placeholderColor ?? AppConstants.subLabelColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
