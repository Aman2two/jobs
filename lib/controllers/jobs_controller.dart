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
    return await ApiHandler.callGetApi(
        url: "$baseUrl$getPostedJobsUrl",
        headers: {'Authorization': token.trim()});
  }

  Future<Map> getAvailableJobs(String token) async {
    return await ApiHandler.callGetApi(
        url: "$baseUrl$applyToJobs", headers: {'Authorization': token.trim()});
  }

  List<Job> jobsList(List<dynamic> data) =>
      data.map((e) => Job.fromJson(e)).toList();

  List<dynamic> dummyData = [
    {
      "title": "Sr Unity Developer",
      "description":
          """3 years in Unity Games development 3D math skills Knowledge of Unity3D including UnityGUI,asset bundles, materials/shaders, and iPhone/Android deployment.version controller\" like git.""",
      "location": "Gurgaon/Gurugram"
    },
    {
      "title": "React Native Developer",
      "description":
          """- Work as a part of a team to build React Native iOS/Android applications for FullStack's client  \n- Architect, build and maintain excellent React Native applications with clean code.""",
      "location": "Gurgaon/Gurugram"
    },
    {
      "title": "React Native Developer",
      "description": """Minimum 4 years of experience in mobile app development\nMust have experience in either android app or iOS app development\nAt least 2 year of experience in React Native app development\nAbility to implement designs and functionality provided by UI/UX teams\nStrong knowledge of JavaScript ES6 \nGood to have knowledge of Redux\nAbility to write the unit test cases for React Native app\nSmart in debugging the bugs and finding the RCA""",
      "location": "Gurgaon/Gurugram"
    },
    {
      "title": "Android Developer - Noida - Digital Payment Company",
      "description": """Strong knowledge of Android SDK, different versions of Android, and how to deal with different screen sizes \nFamiliarity with RESTful APIs to connect Android applications to back-end services\nStrong knowledge of Android UI design principles""",
      "location": "Noida"
    },
  ];
}
