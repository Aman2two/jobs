import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobs/controllers/jobs_controller.dart';
import 'package:jobs/utility/app_variables.dart';
import 'package:jobs/utility/constants.dart';
import 'package:jobs/utility/utility.dart';
import 'package:provider/provider.dart';

class CreateJobScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final JobsController _createJobController = new JobsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(createJobHeader),
      ),
      body: Center(
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(jobsBg), fit: BoxFit.fitWidth),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Card(
                elevation: 10.0,
                color: Colors.white54,
                child: ListView(
                  children: [
                    loginPassword(context),
                    SizedBox(
                      height: 50.0,
                    ),
                    submitText(context),
                  ],
                ),
              ),
            ),
          ),
          Provider.of<DataProvider>(context, listen: true).loaderShowing
              ? defaultLoader(context)
              : SizedBox()
        ]),
      ),
    );
  }

  Widget loginPassword(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: title),
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1,
                controller: _createJobController.tecJobTitle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterTitle;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: description),
                maxLines: 10,
                controller: _createJobController.tecJobDescription,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterDescription;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: location),
                maxLines: 1,
                controller: _createJobController.tecJobLocation,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterLocation;
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
  }

  Widget submitText(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print(_formKey.currentState.validate());
        if (_formKey.currentState.validate()) {
          Provider.of<DataProvider>(context, listen: false).loaderShowing =
              true;
          String token=Provider.of<DataProvider>(context, listen: false).user.token;
          _createJobController.createJob(token).then((value) {
            Provider.of<DataProvider>(context, listen: false).loaderShowing =
                false;

            if (!value[success]) {
              List<dynamic> errorList = (value.containsKey(errors))
                  ? value[errors]
                  : [value[message]];
              String errorString = Utility.parseErrors(errorList);
              _scaffoldKey.currentState.showSnackBar(
                  Utility.getSnackBar(errorString, isError: true));
            } else {
              _scaffoldKey.currentState.showSnackBar(
                  Utility.getSnackBar(createJobSuccess, isError: false));
            }
          });
        }
      },
      child: Text(createJob),
    );
  }
}
