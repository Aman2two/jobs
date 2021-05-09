import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobs/controllers/login_controller.dart';
import 'package:jobs/models/user_model.dart';
import 'package:jobs/screens/dashboard.dart';
import 'package:jobs/screens/signup_screen.dart';
import 'package:jobs/utility/app_variables.dart';
import 'package:jobs/utility/constants.dart';
import 'package:jobs/utility/utility.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = new LoginController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(loginAppBarTitle),
      ),
      body: Center(
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(loginBg), fit: BoxFit.fitWidth),
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
                    signUpText(context),
                    submitText(context),
                    SizedBox(height: 10,),
                    forgotPassword(context),
                    SizedBox(height: 10,)
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

  Widget forgotPassword(BuildContext context) {
    return InkWell(
      child: Text("forgot password",style: Theme.of(context).textTheme.subtitle2,),
      onTap: () {
        _loginController.getResetToken().then((value) {
          if (!value[success]) {
            List<dynamic> errorList =
                (value.containsKey(errors)) ? value[errors] : [value[message]];
            String errorString = Utility.parseErrors(errorList);
            _scaffoldKey.currentState
                .showSnackBar(Utility.getSnackBar(errorString, isError: true));
          } else {
            String token=value[data]['token'];
            Utility.navigateTo(context: context, nextPageName: SignUpScreen(token: token,));
          }
        });
      },
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
                decoration: InputDecoration(hintText: email),
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1,
                controller: _loginController.tecUserName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterEmail;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: password),
                maxLines: 1,
                controller: _loginController.tecPassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterPassword;
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
  }

  Widget signUpText(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Utility.navigateTo(context: context, nextPageName: SignUpScreen());
      },
      child: Text(signText),
    );
  }

  Widget submitText(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print(_formKey.currentState.validate());
        if (_formKey.currentState.validate()) {
          Provider.of<DataProvider>(context, listen: false).loaderShowing =
              true;
          _loginController.loginUser().then((value) {
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
              Utility.writeToSharedPreferences(keyIsLogin, true);
              Utility.writeToSharedPreferences(
                  keyUserData, jsonEncode(value[data]));
              User user = User.fromJson(value[data]);
              Provider.of<DataProvider>(context, listen: false).user = user;
              _scaffoldKey.currentState.showSnackBar(
                  Utility.getSnackBar(loginSuccess, isError: false));
              Future.delayed(Duration(seconds: 2), () {
                Utility.navigateTo(
                    context: context, nextPageName: DashboardScreen());
              });
            }
          });
        }
      },
      child: Text(loginText),
    );
  }
}
