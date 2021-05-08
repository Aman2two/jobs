
// 0 for recruiter and 1 for candidate

import 'package:flutter/material.dart';

class AppVariables extends ChangeNotifier {
  int _userType = 0;
  bool _loaderShowing=false;

  bool get loaderShowing => _loaderShowing;

  set loaderShowing(bool value) {
    _loaderShowing = value;
    notifyListeners();
  }

  int get userType => _userType;

  set userType(int value) {
    _userType = value;
    notifyListeners();
  }


}