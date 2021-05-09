import 'package:flutter/cupertino.dart';
import 'package:jobs/api/apihandler.dart';
import 'package:jobs/utility/constants.dart';

class JobsController {
  final TextEditingController tecJobTitle = new TextEditingController();
  final TextEditingController tecJobDescription = new TextEditingController();
  final TextEditingController tecJobLocation = new TextEditingController();

  Future<Map> createJob(String token) async {
    return await ApiHandler.callPostApi(url: "$baseUrl$jobs", data: {
      'title': tecJobTitle.text,
      'description': tecJobDescription.text.trim(),
      'location': tecJobLocation.text
    }, headers: {
      'Authorization': token.trim()
    });
  }

  Future<Map> getPostedJobs(String token) async {
    return await ApiHandler.callGetApi(url: "$baseUrl$getPostedJobs", headers: {
      'Authorization': token.trim()
    });
  }


}
