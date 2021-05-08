import 'package:dio/dio.dart';
import 'package:jobs/utility/constants.dart';

class ApiHandler {
  static var dio = Dio();

  static signUp(Map<String,dynamic> data) async{
   Response response=await dio.post("$baseUrl$register",data: data);
   print(response);
  }
}
