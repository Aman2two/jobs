

import 'package:flutter/cupertino.dart';
import 'package:jobs/api/apihandler.dart';

class CreateJobController{
  final TextEditingController tecJobTitle=new TextEditingController();
  final TextEditingController tecJobDescription=new TextEditingController();
  final TextEditingController tecJobLocation=new TextEditingController();


  Future<Map> createJob() async{
    return await ApiHandler.createJob({
      'title':tecJobTitle.text,
      'description':tecJobDescription.text.trim(),
      'location':tecJobLocation.text
    });
  }
}