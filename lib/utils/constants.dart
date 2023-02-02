import 'package:flutter/material.dart';
import 'helper.dart';

class Constants {
  static RegExp regEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static  RegExp regPhone = RegExp(r" \+994\s+\([0-9]{2}\)\s+[0-9]{3}\s+[0-9]{2}\s+[0-9]{2}");
  static  int pageIndex = 0;
  static bool?  isLoginBool = false;
  static GlobalKey globalKey =  GlobalKey(debugLabel: 'btm_app_bar');
}
