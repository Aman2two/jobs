import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobs/api/apihandler.dart';
import 'package:jobs/utility/app_variables.dart';
import 'package:jobs/utility/constants.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController tecEmail = new TextEditingController();
  final TextEditingController tecPassword = new TextEditingController();
  final TextEditingController tecConfirmPassword = new TextEditingController();
  final TextEditingController tecName = new TextEditingController();
  final TextEditingController tecSkills = new TextEditingController();
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
                  signUpText(Provider.of<AppVariables>(context, listen: false)
                      .userType),
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
                decoration: InputDecoration(hintText: "Email"),
                maxLines: 1,
                autofocus: true,
                style: Theme.of(context).textTheme.subtitle1,
                controller: tecEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
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
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Confirm Password"),
                maxLines: 1,
                autofocus: true,
                style: Theme.of(context).textTheme.subtitle1,
                controller: tecConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter confirm password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "Name"),
                maxLines: 1,
                controller: tecName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "Skills"),
                maxLines: 1,
                autofocus: true,
                style: Theme.of(context).textTheme.subtitle1,
                controller: tecEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter skills';
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
  }

  Widget signUpText(int userRole) {
    return ElevatedButton(
      onPressed: () {
        print(_formKey.currentState.validate());
        if (_formKey.currentState.validate()) {
          ApiHandler.signUp({
            "email": tecEmail,
            "userRole": userRole,
            "password": tecPassword,
            "confirmPassword": tecConfirmPassword,
            "name": tecName,
            "skills": tecSkills
          });
        }
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
