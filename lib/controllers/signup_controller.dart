

import 'package:flutter/widgets.dart';
import 'package:jobs/api/apihandler.dart';

class SignUpController{
  final TextEditingController tecEmail = new TextEditingController();
  final TextEditingController tecPassword = new TextEditingController();
  final TextEditingController tecConfirmPassword = new TextEditingController();
  final TextEditingController tecName = new TextEditingController();
  final TextEditingController tecSkills = new TextEditingController();

  Future<Map> submitRequest(int userRole) async{
    return await ApiHandler.signUp({
      "email": tecEmail.text,
      "userRole": userRole,
      "password": tecPassword.text,
      "confirmPassword": tecConfirmPassword.text,
      "name": tecName.text,
      "skills": tecSkills.text
    });
  }

}