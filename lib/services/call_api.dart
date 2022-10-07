import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class RemoteServices {
  static const domainName = "https://lifetronsorgapi.azurewebsites.net/";
  // static const header = {
  //   "accept": "application/json",
  //   "token" :
  // };

  Future<T?> apiCalling<T>(
      {required String endPoint,
      required String method,
      Map<dynamic, dynamic>? body,
      Map<String, String>? header}) async {
    final response;
    final String url = domainName + endPoint;
    try {
      if (method == "get") {
        response = await http.get(
          Uri.parse(url),
          headers: header,
        );
      } else if (method == "post") {
        response = await http.post(
          Uri.parse(url),
          // headers: header,
          body: body,
        );
      } else if (method == "put") {
        response = http.put(
          Uri.parse(url),
          // headers: header,
          body: body,
        );
      } else {
        response = http.delete(
          Uri.parse(url),
          // headers: header,
        );
      }
      // log(response.body.toString());
      // log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } on SocketException {
      log("Network Connection Fail.");
    } on TimeoutException {
      log("Connection Time Out");
    } on Error catch (e) {
      log('Error $e');
    }
    return null;
  }
}
