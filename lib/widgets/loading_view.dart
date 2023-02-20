import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
          backgroundColor: AppConstants.primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(AppConstants.whiteColor)),
    );
  }
}
