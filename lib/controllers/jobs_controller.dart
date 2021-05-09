import 'package:flutter/cupertino.dart';
import 'package:jobs/api/apihandler.dart';
import 'package:jobs/models/job.dart';
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
    return await ApiHandler.callGetApi(url: "$baseUrl$getPostedJobsUrl", headers: {
      'Authorization': token.trim()
    });
  }

  Future<Map> getAvailableJobs(String token) async {
    return await ApiHandler.callGetApi(url: "$baseUrl$applyToJobs", headers: {
      'Authorization': token.trim()
    });
  }

  List<Job> jobsList(List<dynamic> data)=>
    data.map((e) =>Job.fromJson(e)).toList();


  List<dynamic> dummyData=[
    {
      "title": "C Developer",
      "description": "job description",
      "location": "Delhi"
    },
    {
      "title": "Java Developer",
      "description": "job description",
      "location": "Gurgaon"
    },
    {
      "title": "C++ Developer",
      "description": "job description",
      "location": "Pune"
    },
    {
      "title": "Dart Developer",
      "description": "job description",
      "location": "Banglore"
    },
  ];



}
