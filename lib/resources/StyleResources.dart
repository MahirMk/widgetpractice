import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StyleResources
{
  static Color tealDarkColor = Colors.teal.shade900;
  static Color tealLightColor = Colors.teal.shade50;
  static Color tealColor = Colors.teal;
  static Color redColor = Colors.red.shade900;
  static Color whiteColor = Colors.white;
  static TextStyle tealTxtColor =  const TextStyle(color: Colors.teal,);

  static Color errorColor =  Colors.red;


  static outLineBorder(context,[Color? myColor])
  {
    return
      OutlineInputBorder(
          borderSide:  BorderSide(color: myColor??Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(20.0)
      );
  }

  static InputDecoration textFieldInputDecoration(context,String? myLabel , Widget? myIcon,String? myHintText) {
    return
      InputDecoration(
        errorBorder: outLineBorder(context,StyleResources.errorColor),
        focusedErrorBorder: outLineBorder(context,StyleResources.errorColor),
        disabledBorder: outLineBorder(context,Theme.of(context).disabledColor),
        enabledBorder: outLineBorder(context),
        focusedBorder:  outLineBorder(context),
        labelText: myLabel,
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        suffixIcon: myIcon,
        hintText: myHintText,
        hintStyle: TextStyle(wordSpacing: 1.w),
      );
  }
}