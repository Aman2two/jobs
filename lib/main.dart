import 'package:flutter/material.dart';
import 'package:jobs/screens/usertype.dart';
import 'package:jobs/utility/app_variables.dart';
import 'package:jobs/utility/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColorLight: Colors.deepPurple[100],
        backgroundColor: Colors.white,
        primaryColorDark: Colors.white,
        buttonColor: Colors.deepPurple,
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(
          headline6: TextStyle(
              color: Colors.white,
              fontSize: 21.0,
              fontWeight: FontWeight.w600),
        )),
        textTheme: TextTheme(
            button: TextStyle(color: Colors.white, fontSize: 18.0),
            headline6: TextStyle(color: Colors.black87, fontSize: 20.0)),
        buttonTheme: ButtonThemeData(
            minWidth: 120.0,
            height: 40.0,
            buttonColor: Colors.deepPurple,
            textTheme: ButtonTextTheme.primary),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (context) => AppVariables(),
          child: UserType(),
        ),
        appBar: AppBar(title: Center(child: Text(userTypeScreenHeader))),
      ),
    );
  }
}
