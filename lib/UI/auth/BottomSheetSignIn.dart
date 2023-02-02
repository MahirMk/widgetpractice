import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widgetpractice/resources/StyleResources.dart';
import 'package:widgetpractice/services/AuthHelper.dart';
import 'package:widgetpractice/utils/constants.dart';
import 'package:widgetpractice/utils/helper.dart';
import 'package:widgetpractice/widgets/MyPrimaryButton.dart';

import '../pages/BottomNavigationBarPage.dart';
import 'BottomSheetSignUp.dart';

class BottomSheetSignIn extends StatefulWidget {
  const BottomSheetSignIn({Key? key}) : super(key: key);

  @override
  State<BottomSheetSignIn> createState() => _BottomSheetSignInState();
}

class _BottomSheetSignInState extends State<BottomSheetSignIn> {

  final _formKey = GlobalKey<FormState>();
  final email = GlobalKey<FormFieldState>();
  final passkey = GlobalKey<FormFieldState>();

  TextEditingController  emailCn = TextEditingController();
  TextEditingController passCn = TextEditingController();

  var auth = Authentication();
  bool? check1 = true;
  bool? obscureText = true;

  //RegExp pass_valid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

 // RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
 // RegExp pass_valid = RegExp(r".{8,}");
 //  bool validatePassword(String pass){
 //    String password = pass.trim();
 //    if(pass_valid.hasMatch(password)){
 //      return true;
 //    }
 //    else{
 //      return false;
 //    }
 //  }



  void _toggle() {
    setState(() {
      obscureText = !obscureText!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding:  EdgeInsets.symmetric(horizontal : 1.1.w),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children:  [
                  SizedBox(height: 1.6.h),
                  Text("Sign In",style: Theme.of(context).textTheme.headline4,),
                  Row(
                    children: [
                      SizedBox(height: 10.h,),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal : 3.1.w),
                        child: Container(
                          height: 5.h,
                          width: 5.h,
                          decoration: BoxDecoration(
                            color: StyleResources.tealLightColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(120),
                              topRight: Radius.circular(120),
                              bottomLeft: Radius.circular(120),
                              bottomRight: Radius.circular(5.0),
                            ),
                          ),
                          child: const Icon(Icons.person_outline,color: Colors.teal),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal : 0.5.w),
                            child: TextFormField(
                              controller: emailCn,
                              keyboardType: TextInputType.emailAddress,
                             // autovalidateMode: AutovalidateMode.onUserInteraction,
                              key: email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                if (!Constants.regEmail.hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                              onChanged: (value) {
                               email.currentState!.validate();
                              },
                              decoration: const InputDecoration(
                                hintText: "Email",
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(height: 8.h,),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal : 3.1.w),
                        child: Container(
                          height: 5.h,
                          width: 5.h,
                          decoration: BoxDecoration(
                            color: StyleResources.tealLightColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(120),
                              topRight: Radius.circular(120),
                              bottomLeft: Radius.circular(120),
                              bottomRight: Radius.circular(5.0),
                            ),
                          ),
                          child: const Icon(Icons.lock_open,color: Colors.teal),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal : 0.5.w),
                            child: TextFormField(
                              controller: passCn,
                              keyboardType: TextInputType.visiblePassword,
                              key: passkey,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                }
                                if (value.length < 8) {
                                  return 'Must be more than 8 character';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                passkey.currentState!.validate();
                              },
                              obscureText: obscureText!,
                              decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _toggle();
                                  },
                                  icon: (obscureText! ? const Icon(Icons.visibility,color: Colors.teal):const Icon(Icons.visibility_off,color: Colors.teal,))
                                ),
                              ),
                            ),
                          ),
                       ),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  MyPrimaryButton(
                    onClick: ()  {
                   //  var em = emailCn.text.toString();
                   //  var psd = passCn.text.toString();


                      if(_formKey.currentState!.validate())
                      {
                        auth.fireAuthSignIn(context,emailCn.text, passCn.text).then((value) async {
                          if(value != null)
                            {
                              User? user = value;
                               FirebaseFirestore.instance.collection(value.uid).where(user.uid);
                               Helper.saveUserLogin(true);
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (_) => const BottomNavigationBarPage()),(route)=> false);
                            }
                        });
                      }

                      // if(_formKey.currentState!.validate())
                      // {
                      //   auth.fireAuthSignIn(context,emailCn.text, passCn.text).then((value){
                      //     if(value != null)
                      //       {
                      //         Map<String,dynamic> allData = {
                      //           "Email": emailCn.text,
                      //           "Password": passCn.text,
                      //           "Uid": value.uid,
                      //         };
                      //         Helper.saveUserLogin(true);
                      //         Helper.saveUserData(jsonEncode(allData));
                      //
                      //         //prefs.setString("userData", jsonEncode(allData));
                      //         // print(json.encode('$allData'));
                      //
                      //         Navigator.pushAndRemoveUntil(context,
                      //             MaterialPageRoute(builder: (_) => const BottomNavigationBarPage()),(route)=> false);
                      //       }
                      //   });
                      //
                      //   // Navigator.of(context).pop();
                      //   // Navigator.of(context).pushReplacement(
                      //   //     MaterialPageRoute(builder: (context)=> const HomePage())
                      //   // );
                      // }
                      // else
                      // {
                      //   print("error");
                      // }
                      },
                    btnTxt: "Sign In",
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 1.2.h),
                        child: Row(
                          children: [
                             Checkbox(
                               activeColor: StyleResources.tealDarkColor,
                                value: check1,
                                onChanged: (val)
                                {
                                  setState(() {
                                    check1 = val;
                                  });
                                },
                            ),
                            Text("Remember Me",style: Theme.of(context).textTheme.bodyText1,),
                            Padding(
                              padding: EdgeInsets.only(left: 9.3.h),
                              child: TextButton(
                                onPressed: (){},
                                child:  Text("Forgot Password?",style: Theme.of(context).textTheme.bodyText1,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: 3.h,),
                   Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.h),
                        child: const Text("Or Sign In with",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                  ),
                  SizedBox(height: 2.h,),
                  MyPrimaryButton(
                      myBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                      ),
                      btnColor: Colors.black,
                      myIcon: const Icon(Icons.apple),
                      onClick: (){},
                      btnTxt: "Sign In With Apple"
                  ),
                  SizedBox(height: 2.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.7.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyPrimaryButton(
                            myPadding: EdgeInsets.symmetric(horizontal: 1.6.h),
                            btnColor: Colors.blue.shade900,
                              onClick: (){
                                auth.faceBookAuth(context).then((value){
                                  if(value != null){
                                    Map<String,dynamic> allData = {
                                      "metadata":  value.email,
                                      "displayName":  value.displayName,
                                      "photoURL":  value.photoURL,
                                    };
                                    Helper.saveUserLogin(true);
                                    Helper.saveUserData(jsonEncode(allData));
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (_) => const BottomNavigationBarPage()),(route)=> false);
                                  }
                                });
                              },
                              btnTxt: "FACEBOOK",
                          ),
                        ),
                        Expanded(
                          child: MyPrimaryButton(
                            myPadding: EdgeInsets.symmetric(horizontal: 1.6.h),
                            btnColor: Colors.red.shade400,
                            onClick: (){
                              auth.googleAuth().then((value){
                                if(value != null){

                                  Map<String,dynamic> allData = {
                                    "gName":  value.displayName,
                                    "gEmail": value.email,
                                    "gPhoto": value.photoURL,
                                    "gGoogleID": value.uid,
                                  };
                                  Helper.saveUserLogin(true);
                                  Helper.saveUserData(jsonEncode(allData));
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (_) => const BottomNavigationBarPage()),(route)=> false);
                                }
                              });
                            },
                            btnTxt: "GOOGLE",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text("Don't have account yet ?",style: Theme.of(context).textTheme.bodyText1,),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
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
                                return  const FractionallySizedBox(
                                    heightFactor: 0.7,
                                    child: BottomSheetSignUp());
                              },
                            );
                          },
                          child: const Text("Sign Up",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
