import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widgetpractice/resources/StyleResources.dart';

class MyPrimaryButton extends StatelessWidget {

 final EdgeInsetsGeometry? myPadding;
 final OutlinedBorder? myBorder;
 final Widget? myIcon;
 final Color? btnColor;
 final  String? btnTxt;
 final VoidCallback? onClick;
  const MyPrimaryButton({super.key, required this.onClick,this.btnTxt,this.btnColor, this.myIcon, this.myBorder, this.myPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: myPadding??EdgeInsets.symmetric(horizontal: 2.6.h),
      child: SizedBox(
        height: 5.3.h,
        width: 86.w,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: btnColor??StyleResources.tealDarkColor,
            shape: myBorder??RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onClick,
          icon: myIcon?? const SizedBox.shrink(),
          label: Text(btnTxt!, style: Theme.of(context).textTheme.button),
        ),
      ),
    );
  }
}
