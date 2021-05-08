import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobs/api/apihandler.dart';
import 'package:jobs/screens/signup_screen.dart';
import 'package:jobs/utility/constants.dart';
import 'package:jobs/utility/utility.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController tecUserName = new TextEditingController();
  final TextEditingController tecPassword = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(loginAppBarTitle),
      ),
      body: Center(
        child: Container(
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
                  signUpText(context),
                  submitText(),
                ],
              ),
            ),
          ),
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
                decoration: InputDecoration(hintText: "Username"),
                maxLines: 1,
                autofocus: true,
                style: Theme.of(context).textTheme.subtitle1,
                controller: tecUserName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return enterUserName;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                maxLines: 1,
                controller: tecPassword,
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
      child: Text('Sign Up'),
    );
  }

  Widget submitText() {
    return ElevatedButton(
      onPressed: () {
        print(_formKey.currentState.validate());
        if (_formKey.currentState.validate()) {
        } else {}
      },
      child: Text('Login'),
    );
  }
}
