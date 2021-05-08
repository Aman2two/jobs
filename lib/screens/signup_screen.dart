import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobs/controllers/signup_controller.dart';
import 'package:jobs/screens/login_screen.dart';
import 'package:jobs/utility/app_variables.dart';
import 'package:jobs/utility/constants.dart';
import 'package:jobs/utility/utility.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final SignUpController _signUpController = new SignUpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(signAppBarTitle),
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(loginBg), fit: BoxFit.fitHeight),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Card(
                  elevation: 10.0,
                  color: Colors.white54,
                  child: Column(
                    children: [
                      loginPassword(context),
                      Spacer(),
                      signUpText(
                          Provider.of<DataProvider>(context, listen: false)
                              .userType,
                          context),
                    ],
                  ),
                ),
              ),
            ),
            Provider.of<DataProvider>(context, listen: true).loaderShowing
                ? defaultLoader(context)
                : SizedBox()
          ],
        ),
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
                decoration: InputDecoration(hintText: name),
                maxLines: 1,
                controller: _signUpController.tecName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterName;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: email),
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1,
                controller: _signUpController.tecEmail,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !Utility.isValidEmail(_signUpController.tecEmail.text)) {
                    return enterEmail;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: password),
                maxLines: 1,
                controller: _signUpController.tecPassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterPassword;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: confirmPassword),
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1,
                controller: _signUpController.tecConfirmPassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterConfirmPassword;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: skillsText),
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1,
                controller: _signUpController.tecSkills,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterSkills;
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
  }

  Widget signUpText(int userRole, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print(_formKey.currentState.validate());
        if (_formKey.currentState.validate()) {
          Provider.of<DataProvider>(context, listen: false).loaderShowing = true;

          _signUpController.submitRequest(userRole).then((value) {
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
              String id = value[data][email.toLowerCase()];
              _scaffoldKey.currentState.showSnackBar(
                  Utility.getSnackBar("$userIdCreatedMsg $id", isError: false));
              Future.delayed(Duration(seconds: 2), () {
                Utility.goBack(context);
              });
            }
          });
        }
      },
      child: Text(buttonProceed),
    );
  }
}
