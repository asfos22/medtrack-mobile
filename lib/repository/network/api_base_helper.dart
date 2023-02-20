import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:medtrack/constants/api_constants.dart';
import 'package:medtrack/widgets/custom_alert_dialog.dart';

import 'api_exceptions.dart';

class ApiBaseHelper {
  String baseUrl;

  ApiBaseHelper({required this.baseUrl});

  Future<dynamic> get(String endpoint, String? identifier, String? token,
      String postBody, BuildContext context) async {
    print('[GET] $endpoint');
    print('$baseUrl$endpoint');
    print("Token");
    print('$token');
    dynamic responseJson;
    try {
      if (token != null) {
        final response = await http.get(
          Uri.parse('$baseUrl$endpoint'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            HttpHeaders.acceptHeader: APIConstants.contentTypeApplicationJson,
          },
        );

        responseJson = _returnResponse(response, identifier, context);
      } else {
        final response =
            await http.get(Uri.parse('$baseUrl$endpoint'), headers: {
          HttpHeaders.acceptHeader: APIConstants.contentTypeApplicationJson,
        });
        responseJson = _returnResponse(response, null, context);
      }
    } on SocketException {
      CustomAlertDialog(
          context: context,
          alertTitle: 'Error Alert',
          alertContent: 'Hmm,sorry we could not proceed',
          buttonText: 'Ok',
          buttonAction: () => Navigator.pop(context)).createDialog();
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String endpoint, String? identifier, String? token,
      String postBody, BuildContext context) async {
    print('[POST] $endpoint');
    dynamic responseJson;
    try {
      if (token != null) {
        final response = await http
            .post(Uri.parse('$baseUrl$endpoint'), body: postBody, headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader:
              APIConstants.contentTypeApplicationJson,
        });
        responseJson = _returnResponse(response, identifier, context);
      } else {
        final response = await http
            .post(Uri.parse('$baseUrl$endpoint'), body: postBody, headers: {
          HttpHeaders.contentTypeHeader:
              APIConstants.contentTypeApplicationJson,
        });
        responseJson = _returnResponse(response, identifier, context);
      }
    } on SocketException {
      CustomAlertDialog(
          context: context,
          alertTitle: 'Error Alert',
          alertContent: 'No Internet Connection',
          buttonText: 'Ok',
          buttonAction: () => Navigator.pop(context)).createDialog();
      throw FetchDataException('No Internet Connection');
    }
    print('POST Received!');
    return responseJson;
  }

  Future<dynamic> put(String endpoint, String? identifier, String? token,
      String postBody, BuildContext context) async {
    print('[PUT] $baseUrl$endpoint AND $token');
    dynamic responseJson;
    try {
      if (token != null) {
        final response = await http
            .put(Uri.parse('$baseUrl$endpoint'), body: postBody, headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          APIConstants.headerAuth: token,
          HttpHeaders.contentTypeHeader:
              APIConstants.contentTypeApplicationJson,
        });
        responseJson = _returnResponse(response, identifier, context);
      } else {
        final response = await http
            .post(Uri.parse('$baseUrl$endpoint'), body: postBody, headers: {
          HttpHeaders.contentTypeHeader:
              APIConstants.contentTypeApplicationJson,
        });
        responseJson = _returnResponse(response, identifier, context);
      }
    } on SocketException {
      CustomAlertDialog(
          context: context,
          alertTitle: 'Error Alert',
          alertContent: 'No Internet Connection',
          buttonText: 'Ok',
          buttonAction: () => Navigator.pop(context)).createDialog();
      throw FetchDataException('No Internet Connection');
    }
    print('POST Received!');
    return responseJson;
  }

  Future<dynamic> delete(String endpoint, String? identifier, String? token,
      String postBody, BuildContext context) async {
    print('[Delete] $endpoint');
    dynamic responseJson;
    try {
      if (token != null) {
        final response = await http
            .delete(Uri.parse('$baseUrl$endpoint'), body: postBody, headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          APIConstants.headerAuth: token,
          HttpHeaders.contentTypeHeader: APIConstants.contentTypeApplicationJson
        });
        responseJson = _returnResponse(response, identifier, context);
      } else {
        final response = await http
            .post(Uri.parse('$baseUrl$endpoint'), body: postBody, headers: {
          HttpHeaders.contentTypeHeader:
              APIConstants.contentTypeApplicationJson,
        });
        responseJson = _returnResponse(response, identifier, context);
      }
    } on SocketException {
      CustomAlertDialog(
          context: context,
          alertTitle: 'Error Alert',
          alertContent: 'No Internet Connection',
          buttonText: 'Ok',
          buttonAction: () => Navigator.pop(context)).createDialog();
      throw FetchDataException('No Internet Connection');
    }
    print('DELETE Received!');
    return responseJson;
  }

  dynamic _returnResponse(
      http.Response response, String? identifier, BuildContext context) {
    var responseJson = json.decode(response.body);
    return responseJson;
  }


  //--
  //method upload photo
  Future uploadImage(String endpoint,String? token, String postBody, BuildContext context) async {

    try {
      Map<String, String> headers = {"authorization": 'Bearer $token'};
      final uri =
      Uri.parse('$baseUrl$endpoint');
      var request = http.MultipartRequest(APIConstants.postRequestMethod, uri);
      var fileUpload = await http.MultipartFile.fromPath("picture", postBody);

      request.headers.addAll(headers);
      request.files.add(fileUpload);
      //var response = await request.send();
      http.Response response = await http.Response.fromStream(await request.send());
      print("Result: ${response.statusCode}");

      print( response.body);
     
    } on SocketException {
      CustomAlertDialog(
          context: context,
          alertTitle: 'Error Alert',
          alertContent: 'Hmm,sorry we could not proceed',
          buttonText: 'Ok',
          buttonAction: () => Navigator.pop(context)).createDialog();
      throw FetchDataException('Sorry error processing request');
    }
    return '';
  }

}
