
// 0 for recruiter and 1 for candidate

import 'package:flutter/material.dart';
import 'package:jobs/models/user_model.dart';

class DataProvider extends ChangeNotifier {
  int _userType = 1;
  bool _loaderShowing=false;
  User user;

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