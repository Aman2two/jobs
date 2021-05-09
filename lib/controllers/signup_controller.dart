

import 'package:flutter/widgets.dart';
import 'package:jobs/api/apihandler.dart';
import 'package:jobs/utility/constants.dart';

class SignUpController{
  final TextEditingController tecEmail = new TextEditingController();
  final TextEditingController tecPassword = new TextEditingController();
  final TextEditingController tecConfirmPassword = new TextEditingController();
  final TextEditingController tecName = new TextEditingController();
  final TextEditingController tecSkills = new TextEditingController();
  String resetToken="";

  Future<Map> submitRequest(int userRole) async{
    return await ApiHandler.callPostApi(url:"$baseUrl$register",data:{
      "email": tecEmail.text,
      "userRole": userRole,
      "password": tecPassword.text,
      "confirmPassword": tecConfirmPassword.text,
      "name": tecName.text,
      "skills": tecSkills.text
    });
  }

  Future<Map> resetRequest() async{
    return await ApiHandler.callPostApi(url:"$baseUrl$resetPassword",data:{
      "password": tecPassword.text,
      "confirmPassword": tecConfirmPassword.text,
      "token": resetToken,
    });
  }

  bool isReset()=> resetToken.isNotEmpty;

}