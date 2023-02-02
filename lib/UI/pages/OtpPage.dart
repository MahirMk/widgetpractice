import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widgetpractice/models/AuthModel.dart';
import 'package:widgetpractice/resources/StyleResources.dart';
import 'package:widgetpractice/services/database.dart';
import 'package:widgetpractice/widgets/MyPrimaryButton.dart';

import '../../services/AuthHelper.dart';
import '../../utils/helper.dart';
import 'BottomNavigationBarPage.dart';

class OtpPage extends StatefulWidget {
 late  Auth? allData;
 final String? id;
   OtpPage({super.key,  this.allData, this.id,});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  var auth = Authentication();
  User? user;

  // String? userName;
  // String? phoneNo;
  // String? password;
  // String? email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.allData!.userName);
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fillColor = Color(0xFF76ECD3);
    const borderColor = Color(0xFF011A15);
    final defaultPinTheme = PinTheme(
      width: 14.w,
      height: 10.h,
      textStyle: const TextStyle(
        fontSize: 22,
        color:  Color(0xFF011A15),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 6,
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
              AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              validator: (value) {
                return null;
              },
              // onClipboardFound: (value) {
              //   debugPrint('onClipboardFound: $value');
              //   pinController.setText(value);
              // },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 5.w,
                    height: 0.5.h,
                    color: StyleResources.tealColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: StyleResources.tealColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: StyleResources.tealColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          SizedBox(height: 4.h,),
          MyPrimaryButton(
            onClick: () {
              auth.verifyOTP(context,pinController.text,widget.id!).then((value){
                print(value!.uid);
                  auth.fireAuthSignUp(context,widget.allData!.email!,widget.allData!.password!).then((value) async {
                  if(value != null)
                    {
                      Helper.saveUserLogin(true);
                      //Helper.saveUserData(jsonEncode(widget.allData));
                      //Database.saveDataBase(authAllData: Auth(uid: value.uid));
                      Database.saveDataBase(authAllData: widget.allData);
                      Helper.saveUidData(value.uid);
                      //  var getData =  FirebaseFirestore.instance.collection(Database.saveFdUserTable);
                      //   var userData = await getData.doc(value.uid).get();
                      //  var data = userData.data()! as Map<String, dynamic>;
                      //Auth profileData = Auth.fromJson(data);
                      // profileData.toJson();
                     Navigator.pushAndRemoveUntil(context,
                         MaterialPageRoute(builder: (_) => const BottomNavigationBarPage()),(route)=> false);
                    }
                  });
              });
            },
            btnTxt: 'validate',
          ),
        ],
      ),
    );
  }
}
