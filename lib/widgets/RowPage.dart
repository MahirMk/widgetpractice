import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

rowHP(context,String? text1,String text2){
  return
  Row(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Text(
          text1!,style: Theme.of(context).textTheme.bodyText1,

        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Text(text2,
            style: Theme.of(context).textTheme.bodyText1),
      ),
    ],
  );
}