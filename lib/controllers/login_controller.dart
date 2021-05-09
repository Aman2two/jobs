import 'package:flutter/cupertino.dart';
import 'package:jobs/api/apihandler.dart';
import 'package:jobs/utility/constants.dart';

class LoginController {
  final TextEditingController tecUserName = new TextEditingController();
  final TextEditingController tecPassword = new TextEditingController();

  Future<Map> loginUser() async {
    return await ApiHandler.callPostApi(
        url: "$baseUrl$loginApi",
        data: {'email': tecUserName.text, 'password': tecPassword.text});
  }
}
