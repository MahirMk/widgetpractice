import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widgetpractice/resources/StyleResources.dart';
import 'package:widgetpractice/widgets/MyPrimaryButton.dart';

import '../auth/BottomSheetSignIn.dart';
import '../auth/BottomSheetSignUp.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration:  BoxDecoration(
              gradient:  LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.1, 0.4],
                colors: [
                  Colors.teal.shade300,
                  Colors.white,
                ],
              ),
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Image.asset('img/verify.png',width: 180,color: StyleResources.tealDarkColor),
                SizedBox(height: 26.h),
                MyPrimaryButton(
                  onClick: (){
                    showModalBottomSheet(
                      context: context,
                         isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                    ),
                    ),
                        builder: (BuildContext context)
                        {
                          return SizedBox(height: 70.h,
                              child: const BottomSheetSignIn());
                        },
                    );
                  },
                  btnTxt: "SIGN IN",
                ),
                SizedBox(height: 2.5.h),
                MyPrimaryButton(
                  onClick: (){
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (BuildContext context)
                      {
                        return  SizedBox(height: 70.h,
                            child: const BottomSheetSignUp());
                      },
                    );
                  },
                  btnTxt: "SIGN UP",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
