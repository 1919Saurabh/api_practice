import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo_project/model/send_token_model.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static const domainName = "https://lifetronsorgapi.azurewebsites.net/";
  static const header = {
    "accept": "application/json",
  };
  Future<UserData?> apiCalling({
    required String endPoint,
    required String method,
    Map<dynamic, dynamic>? body,
  }) async {
    final response;
    final String url = domainName + endPoint;
    try {
      if (method == "get") {
        response = http.get(
          Uri.parse(url),
          headers: header,
        );
      } else if (method == "post") {
        response = await http.post(
          Uri.parse(url),
          headers: header,
          body: body,
        );
      } else if (method == "put") {
        response = http.put(
          Uri.parse(url),
          headers: header,
          body: body,
        );
      } else {
        response = http.delete(
          Uri.parse(url),
          headers: header,
        );
      }

      if (response.statusCode == 200) {
        return UserData.fromJson(json.decode(response.body));
        // log(response.body.toString());
      }
    } on SocketException {
      log("Network Connection Fail.");
    } on TimeoutException {
      log("Connection Time Out");
    } on Error catch (e) {
      log('Error $e');
    }
  }
}
