import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobs/models/user_model.dart';
import 'package:jobs/screens/dashboard.dart';
import 'package:jobs/screens/login_screen.dart';
import 'package:jobs/utility/app_variables.dart';
import 'package:jobs/utility/constants.dart';
import 'package:jobs/utility/utility.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(jobsBg), fit: BoxFit.fitWidth),
        ),
        child: FutureBuilder<SharedPreferences>(
          builder: (context, snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.none:
                return defaultLoader(context);
                break;
              case ConnectionState.waiting:
                return defaultLoader(context);
                break;
              case ConnectionState.active:
                return defaultLoader(context);
                break;
              case ConnectionState.done:
                String data = snapShot.data.getString(keyUserData);
                if (data == null) {
                  return firstTimeUi(context);
                } else {
                  User user = User.fromJson(jsonDecode(data));
                  Provider.of<DataProvider>(context).user = user;
                  Future.delayed(Duration(milliseconds: 500), () {
                    Utility.navigateTo(
                        context: context, nextPageName: DashboardScreen());
                  });
                  return defaultLoader(context);
                }
                break;
            }
            return null;
          },
          future: SharedPreferences.getInstance(),
        ));
  }

  Widget firstTimeUi(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30.0,
        ),
        Text(
          userTypeHeadText,
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(
          height: 50.0,
        ),
        userTypeSelector(context),
        Spacer(),
        proceedWidget(context)
      ],
    );
  }

  Widget userTypeSelector(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, appVariable, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Radio(
              value: 1,
              groupValue:
                  Provider.of<DataProvider>(context, listen: false).userType,
              onChanged: (value) => changeValue(context, value)),
          GestureDetector(
              onTap: () {
                changeValue(context, 0);
              },
              child: Text(
                userTypeRecruiter,
                style: Theme.of(context).textTheme.headline6,
              )),
          SizedBox(
            width: 10,
          ),
          Radio(
              value: 0,
              groupValue:
                  Provider.of<DataProvider>(context, listen: false).userType,
              onChanged: (value) => changeValue(context, value)),
          GestureDetector(
              onTap: () {
                changeValue(context, 1);
              },
              child: Text(
                userTypeCandidate,
                style: Theme.of(context).textTheme.headline6,
              )),
        ],
      );
    });
  }

  Widget proceedWidget(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Utility.navigateTo(context: context, nextPageName: LoginScreen());
      },
      child: Text(proceedText),
    );
  }

  void changeValue(BuildContext context, int value) {
    Provider.of<DataProvider>(context, listen: false).userType = value;
  }
}
