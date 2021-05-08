import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utility {
  static navigateTo(
      {@required BuildContext context, @required Widget nextPageName}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => nextPageName));
  }

  static bool isValidEmail(String data) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(data);
  }

  static String parseErrors(List<dynamic> list) {
    StringBuffer stringBuffer = new StringBuffer();
    list.forEach((element) {
      if (element is Map) {
        stringBuffer.writeln(element.values.first);
      } else {
        stringBuffer.writeln(element);
      }
    });
    return stringBuffer.toString();
  }

  static SnackBar getSnackBar(String text, {bool isError = false}) {
    return SnackBar(
      content: Container(
        height: 50.0,
        child: Text(
          text,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: isError ? Colors.red[800] : Colors.black,
    );
  }
}
