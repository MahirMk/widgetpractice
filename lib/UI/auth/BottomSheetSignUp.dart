import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widgetpractice/models/AuthModel.dart';
import 'package:widgetpractice/services/database.dart';
import 'package:widgetpractice/widgets/AuthData.dart';

import '../../resources/StyleResources.dart';
import '../../services/AuthHelper.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../widgets/MyPrimaryButton.dart';
import '../pages/BottomNavigationBarPage.dart';
import '../pages/OtpPage.dart';
import 'BottomSheetSignIn.dart';

class BottomSheetSignUp extends StatefulWidget {
  const BottomSheetSignUp({Key? key}) : super(key: key);

  @override
  State<BottomSheetSignUp> createState() => _BottomSheetSignUpState();
}

class _BottomSheetSignUpState extends State<BottomSheetSignUp> {

  final _formKey = GlobalKey<FormState>();
  final userName = GlobalKey<FormFieldState>();
  final phone = GlobalKey<FormFieldState>();
  final email = GlobalKey<FormFieldState>();
  final passkey = GlobalKey<FormFieldState>();

  bool? obscureText = true;

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();

  var auth = Authentication();

  String? userEmail;

  final FirebaseAuth phAuth = FirebaseAuth.instance;
  User? user;
  String? verificationID;

  String? dbUserName;
  String? dbPhoneNumber;
  String? dbEmail;
  String? dbPassword;



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
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
       // padding:  EdgeInsets.symmetric(horizontal : 1.1.w,vertical: 1.2.h),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children:  [
                SizedBox(height: 2.0.h),
                const Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    SizedBox(height: 6.h,),
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
                            controller: _userName,
                            keyboardType: TextInputType.text,
                            key: userName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              userName.currentState!.validate();
                            },
                            decoration: const InputDecoration(
                              hintText: "User Name",
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(height: 6.h,),
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
                        child: const Icon(Icons.mobile_friendly,color: Colors.teal),
                      ),
                    ),
                    Expanded( 
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal : 0.5.w),
                          child: TextFormField(
                            controller: _phoneNumber,
                            key: phone,
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'This Field is required';
                              }
                              if (value.length < 10) {
                                return 'please enter valid phone number';
                              }
                              //  else if (!Constants.regPhone.hasMatch(value)) {
                              //   return "Please enter a valid phone number";
                              // }
                              return null;
                            },
                            onChanged: (value) {
                              phone.currentState!.validate();
                            },
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Phone No",
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(height: 6.h,),
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
                        child: const Icon(Icons.email,color: Colors.teal),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal : 0.5.w),
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            //autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    SizedBox(height: 6.h,),
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
                          controller: _password,
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
                  onClick: () async {
                  var  id = await Helper.getUidData();
                    var userName = _userName.text;
                    var phoneNumber = _phoneNumber.text;
                    var email = _email.text;
                    var password = _password.text;
                    var uid = id;
                    // Map<String,dynamic> allData = {
                    //   "UserName": _userName.text,
                    //   "Phone": _phoneNumber.text,
                    //   "Email": _email.text,
                    //   "Password": _password.text,
                    // };
                    // Database.saveDataBase(authAllData: allData);
                    // Helper.saveUidData(value.uid);
                    // Helper.saveUserLogin(true);


                    // User? user = value;
                    // await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
                    //   "userName" : userName,
                    //   "phoneNumber" : phoneNumber,
                    //   "email" : email,
                    //   "password" : password,
                    //   "uid" : value.uid
                    // }).then((value){
                    //   print('Data Inserted');
                    // });
                    // Helper.saveUserLogin(true);
                    // Navigator.pushAndRemoveUntil(context,
                    //     MaterialPageRoute(builder: (_) =>  BottomNavigationBarPage()),(route)=> false);

                    Auth allData = Auth(userName: userName,phoneNumber: phoneNumber, email: email, password: password, uid: uid);
                    if(_formKey.currentState!.validate()){
                      phAuth.verifyPhoneNumber(
                        phoneNumber: '+91${_phoneNumber.text}',
                        verificationCompleted: (PhoneAuthCredential credential) async {
                          await phAuth.signInWithCredential(credential).then((value) {
                            print("You are logged in successfully");
                          });
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          //  print(e.message);
                          print("Your verification is Failed");
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return SizedBox(
                                  height: 70.h,
                                  child: OtpPage(allData: allData,id: verificationId,)
                              );
                            },
                          );
                    // Navigator.pushAndRemoveUntil(context,
                    //     MaterialPageRoute(builder: (_) =>  const BottomNavigationBarPage()),(route)=> false);
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    }

                    /// email & password///
                    // auth.fireAuthSignUp(context,_email.text,_password.text).then((value){
                    //   if(value != null)
                    //   {
                    //     Map<String,dynamic> allData = {
                    //       "Email": _email.text,
                    //       "Password": _password.text,
                    //       "Uid": value.uid,
                    //     };
                    //     Helper.saveUserLogin(true);
                    //     Helper.saveUserData(jsonEncode(allData));
                    //
                    //
                    //
                    //
                    //   }
                    // });
                    /// otp method ///
                    // if(_formKey.currentState!.validate()) {
                    //   Map<String, dynamic> allData = {
                    //     "UserName": _userName.text,
                    //     "Phone": _phoneNumber.text,
                    //     "Email": _email.text,
                    //     "Password": _password.text,
                    //     "otp": verificationID,
                    //   };
                    //   phAuth.verifyPhoneNumber(
                    //     phoneNumber: '+91${_phoneNumber.text}',
                    //     verificationCompleted: (PhoneAuthCredential credential) async {
                    //    //   await phAuth.signInWithCredential(credential).then((value) {
                    //         print("Your verification is successfully");
                    //    //   });
                    //     },
                    //     verificationFailed: (FirebaseAuthException e) {
                    //     //  print(e.message);
                    //       print("Your verification is Failed");
                    //     },
                    //     codeSent: (String verificationId, int? resendToken) {
                    //       showModalBottomSheet(
                    //         context: context,
                    //         isScrollControlled: true,
                    //         shape: const RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.vertical(
                    //             top: Radius.circular(30),
                    //           ),
                    //         ),
                    //         builder: (BuildContext context) {
                    //           return SizedBox(
                    //               height: 70.h,
                    //               child: OtpPage(allData: allData,verificationID: verificationId,)
                    //           );
                    //         },
                    //       );
                    //     },
                    //     codeAutoRetrievalTimeout: (String verificationId) {},
                    //   );
                    // }
                  },
                  btnTxt: "SIGN UP",
                ),
                SizedBox(height: 1.8.h,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.h),
                    child: Text("Or Sign In with",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: StyleResources.tealColor),),
                  ),
                ),
                SizedBox(height: 1.5.h,),
                MyPrimaryButton(
                    myBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    btnColor: Colors.black,
                    myIcon: const Icon(Icons.apple),
                    onClick: (){},
                    btnTxt: "Sign In With Apple"
                ),
                SizedBox(height: 1.5.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.7.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyPrimaryButton(
                          myPadding: EdgeInsets.symmetric(horizontal: 1.6.h),
                          btnColor: Colors.blue.shade900,
                          onClick: () async {
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
                                    MaterialPageRoute(builder: (_) =>  BottomNavigationBarPage()),(route)=> false);
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
                SizedBox(height: 0.8.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("already have account yet ?",style: TextStyle(color: StyleResources.tealColor),),
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
                                  child: BottomSheetSignIn());
                            },
                          );
                        },
                        child: const Text("Sign In",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)
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
// await phAuth.verifyPhoneNumber(
//                           phoneNumber: '+91 ${_phoneNumber.text}',
//                           codeSent: (String verificationId, int? resendToken) async {
//                             // Update the UI - wait for the user to enter  the SMS code
//                            otp = verificationId;
//                            String smsCode = otp;
//
//                            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
//                            setState(() async {
//                              smsCode = verificationId;
//                              await phAuth.signInWithCredential(credential).then((value){
//                                print('complete');
//                              });
//                            });
//                           },
//                           verificationCompleted: (PhoneAuthCredential credential) async {
//                              await phAuth.signInWithCredential(credential);
//                           },
//                           timeout: const Duration(seconds: 60),
//                           codeAutoRetrievalTimeout: (String verificationId) {
//                           },
//                           verificationFailed: (FirebaseAuthException e) {
//                             if (e.code == 'invalid-phone-number') {
//                               print('The provided phone number is not valid.');
//                             }
//                             // Handle other errors
//                           },
//                         );

// showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(30),
//                             ),
//                           ),
//                           builder: (BuildContext context) {
//                             return SizedBox(
//                                 height: 70.h,
//                                 child: OtpPage(allData: allData, credential: otp,)
//                             );
//                           },
//                         );

