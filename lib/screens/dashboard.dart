import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobs/screens/createjob_screen.dart';
import 'package:jobs/screens/viewjobs.dart';
import 'package:jobs/utility/app_variables.dart';
import 'package:jobs/utility/constants.dart';
import 'package:jobs/utility/utility.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(dashboardScreenHeader),
        actions: [
          InkWell(
            child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.logout)),
            onTap: () {
              Utility.logoutFromApp(context);
            },
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          showDialog(
              context: context,
              builder: (context) {
                return dialogWithMessage(text: exitMessage);
              });
          return null;
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(dashboardBg), fit: BoxFit.fitWidth),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  userLayout(context),
                  Provider.of<DataProvider>(context).user.userRole == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            addJob(context),
                            viewJobCandidates(context)
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            viewJobs(context),
                            // viewJobCandidates(context)
                          ],
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userLayout(BuildContext context) {
    String userName = Provider.of<DataProvider>(context).user.name;
    String email = Provider.of<DataProvider>(context).user.email;
    return Container(
        color: Colors.deepPurple[200],
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 10.0,
            ),
            Provider.of<DataProvider>(context).user.userRole == 0
                ? Text(Provider.of<DataProvider>(context).user.skills,
                    style: Theme.of(context).textTheme.headline6)
                : SizedBox(),
            SizedBox(
              height: 10.0,
            ),
            Text(
              Provider.of<DataProvider>(context).user.userRole == 1
                  ? "Hi $userName, add jobs or view candidates for applied jobs"
                  : "Hi $userName, search and apply for  jobs",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ));
  }

  Widget viewJobs(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Utility.navigateTo(context: context, nextPageName: ViewJobCandidates());
      },
      child: Text('View Available Jobs'),
    );
  }

  Widget addJob(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Utility.navigateTo(context: context, nextPageName: CreateJobScreen());
      },
      child: Text('Add Job'),
    );
  }

  Widget viewJobCandidates(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Utility.navigateTo(context: context, nextPageName: ViewJobCandidates());
      },
      child: Text('View Job Candidates'),
    );
  }
}
