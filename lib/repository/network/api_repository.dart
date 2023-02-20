import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';

import 'api_base_helper.dart';

class APIRepository {
  // Class Attributes
  String baseUrl;

  AuthModel authModel = AuthModel();

  // Class Constructor
  APIRepository({
    required this.baseUrl,
  });

  late String _body;
  late final ApiBaseHelper _helper = ApiBaseHelper(baseUrl: baseUrl);

  Future<dynamic> apiParam(
      Map map, var media, String endpoint, String method, BuildContext context) async {
    // send payload

    dynamic response;

    final result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      CustomAlertDialog(
          barrierDismissible: true,
          context: context,
          alertTitle: 'Info Alert',
          alertContent: AppConstants.noInternet,
          buttonText: 'Ok',
          buttonAction: () => Navigator.pop(context)).createDialog();
      return response;
    }

    _body = jsonEncode(map);
    print(endpoint);
    print(baseUrl);
    print(_body);
    print("ddddd");
    print(method);
    // var response;
    // http.Response ?response;

    if (method == APIConstants.postRequestMethod) {
      response = await _helper.post(
          endpoint, null, authModel.getUserToken() ?? '', _body, context);
    }

    if (method == APIConstants.putRequestMethod) {
      response = await _helper.put(
          endpoint, null, authModel.getUserToken() ?? '', _body, context);
    }

    if (method == APIConstants.getRequestMethod) {
      response = await _helper.get(
          endpoint, null, authModel.getUserToken() ?? '', _body, context);
    }

    if (method == APIConstants.deleteRequestMethod) {
      response = await _helper.delete(
          endpoint, null, authModel.getUserToken() ?? '', _body, context);
    }

    if (method == APIConstants.multipartRequest) {
      response = await _helper. uploadImage(
          endpoint, authModel.getUserToken() ?? '', media, context);
    }

    return response;
  }
}
