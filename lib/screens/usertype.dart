import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobs/screens/login_screen.dart';
import 'package:jobs/utility/app_variables.dart';
import 'package:jobs/utility/constants.dart';
import 'package:jobs/utility/utility.dart';
import 'package:provider/provider.dart';

class UserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(userBg), fit: BoxFit.fitHeight),
      ),
      child: Column(
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
      ),
    );
  }

  Widget userTypeSelector(BuildContext context) {
    return Consumer<AppVariables>(builder: (context, appVariable, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Radio(
              value: 0,
              groupValue:
                  Provider.of<AppVariables>(context, listen: false).userType,
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
              value: 1,
              groupValue:
                  Provider.of<AppVariables>(context, listen: false).userType,
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
    Provider.of<AppVariables>(context, listen: false).userType = value;
  }
}
