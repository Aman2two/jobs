import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jobs/utility/constants.dart';
import 'package:jobs/utility/utility.dart';

class ApiHandler {
  static var dio = Dio();

  static Future<Map<dynamic,dynamic>> signUp(Map<String,dynamic> data) async{
    try {
      print(data.toString());
      Response response = await dio.post(
          "$baseUrl$register", data: jsonEncode(data));
      print(response);
      return response.data;
    }catch(e){
     return handleError(e);
    }

  }

  static Future<Map<dynamic,dynamic>> login(Map<String,dynamic> data) async{
    try {
      print(data.toString());
      Response response = await dio.post(
          "$baseUrl$loginApi", data: jsonEncode(data));
      print(response);
      return response.data;
    }catch(e){
      return handleError(e);
    }

  }

  static Future<Map<dynamic,dynamic>> createJob(Map<String,dynamic> data) async{
    try {
      print(data.toString());
      Response response = await dio.post(
          "$baseUrl$jobs", data: jsonEncode(data));
      print(response);
      return response.data;
    }catch(e){
      return handleError(e);
    }

  }

  static handleError(e){
    if(e.type==DioErrorType.DEFAULT){
      return {
        'success':false,
        'message':"Error Connecting to server"
      };
    }else {
      return e.response.data;
    }
}

}
