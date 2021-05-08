

import 'package:flutter/cupertino.dart';
import 'package:jobs/api/apihandler.dart';

class LoginController{
  final TextEditingController tecUserName = new TextEditingController();
  final TextEditingController tecPassword = new TextEditingController();


  Future<Map> loginUser() async{
    return await ApiHandler.login({
      'email':tecUserName.text,
      'password':tecPassword.text
    });
  }
}