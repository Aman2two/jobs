import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobs/controllers/jobs_controller.dart';
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
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(searchBg), fit: BoxFit.fitHeight),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Card(
                  elevation: 10.0,
                  color: Colors.white54,
                  child: jobsListWidget()),
            ),
          ),
          Provider.of<DataProvider>(context, listen: true).loaderShowing
              ? defaultLoader(context)
              : SizedBox()
        ]),
      ),
    );
  }

  Widget jobsListWidget() {
    return SizedBox();
  }
}
