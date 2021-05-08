import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



 class Utility {
  static navigateTo({@required BuildContext context, @required Widget nextPageName}) =>
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => nextPageName));
}
