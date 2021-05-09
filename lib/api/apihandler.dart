import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiHandler {
  static var dio = Dio();

  static Future<Map<dynamic, dynamic>> callPostApi(
      {@required String url,
      @required Map<String, dynamic> data,
      Map<String, dynamic> headers}) async {
    try {
      print(data.toString());
      if (headers != null) dio.options.headers.addAll(headers);
      Response response = await dio.post(url, data: jsonEncode(data));
      print(response);
      return response.data;
    } catch (e) {
      return handleError(e);
    }
  }

  static Future<Map<dynamic, dynamic>> callGetApi(
      {@required String url,
      Map<String, dynamic> data,
      Map<String, dynamic> headers}) async {
    try {
      print(data.toString());
      dio.options.headers.addAll(headers);
      Response response = await dio.get(Uri.decodeFull(url), queryParameters: data);
      print(response);
      return response.data;
    } catch (e) {
      return handleError(e);
    }
  }

  static handleError(e) {
    if (e.type == DioErrorType.DEFAULT) {
      return {'success': false, 'message': "Error Connecting to server"};
    } else {
      return e.response.data;
    }
  }
}
