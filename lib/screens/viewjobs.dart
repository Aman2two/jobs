import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobs/controllers/jobs_controller.dart';
import 'package:jobs/models/job.dart';
import 'package:jobs/utility/app_variables.dart';
import 'package:jobs/utility/constants.dart';
import 'package:jobs/utility/utility.dart';
import 'package:provider/provider.dart';

class ViewJobCandidates extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final JobsController _jobsController = new JobsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(searchJobsHeader),
      ),
      body: Center(
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(searchBg), fit: BoxFit.fitWidth),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Card(
                  elevation: 10.0,
                  color: Colors.white10,
                  child: jobsListWidget(context)),
            ),
          ),
          Provider.of<DataProvider>(context, listen: true).loaderShowing
              ? defaultLoader(context)
              : SizedBox()
        ]),
      ),
    );
  }

  Widget jobsListWidget(BuildContext context) {
    String token = Provider.of<DataProvider>(context, listen: false).user.token;
    int userRole =
        Provider.of<DataProvider>(context, listen: false).user.userRole;
    return FutureBuilder(
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.none &&
            snapShot.hasData == null) {
          return noDataFound(context);
        } else if (snapShot.connectionState == ConnectionState.waiting) {
          return defaultLoader(context);
        } else {
          var value = snapShot.data;
          // if (!value[success]) {
          //   List<dynamic> errorList =
          //       (value.containsKey(errors)) ? value[errors] : [value[message]];
          //   String errorString = Utility.parseErrors(errorList);
          //   return noDataFound(context);
          // } else {
          // value[data];
          List<Job> list = _jobsController.jobsList(_jobsController.dummyData);
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return singleJobCard(list[index], context);
              });
          // }
        }
      },
      future: userRole == 1
          ? _jobsController.getPostedJobs(token)
          : _jobsController.getAvailableJobs(token),
    );
  }

  Widget singleJobCard(Job jobObj, BuildContext context) {
    return Card(
      color: Colors.orangeAccent,
      margin: EdgeInsets.all(10.0),
      elevation: 4.0,
      child: Padding(
        padding:  EdgeInsets.all(5.0),
        child: Column(children: [
          Text(
            jobObj.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 5.0),
          Text(
            jobObj.description,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 5.0),
          Text(
            " Location: ${jobObj.location}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ]),
      ),
    );
  }

  Widget noDataFound(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'No jobs found..',
          style: Theme.of(context).textTheme.headline4,
        ));
  }
}
