import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widgetpractice/models/AuthModel.dart';
import 'package:widgetpractice/resources/StyleResources.dart';
import 'package:widgetpractice/services/database.dart';
import 'package:widgetpractice/widgets/MyPrimaryButton.dart';
import '../../services/AuthHelper.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage( {Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeInput = TextEditingController();

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final userName = GlobalKey<FormFieldState>();
  final phone = GlobalKey<FormFieldState>();
  final email = GlobalKey<FormFieldState>();
  final passkey = GlobalKey<FormFieldState>();

  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  bool? obscureText = true;

  void _toggle() {
    setState(() {
      obscureText = !obscureText!;
    });
  }
  String? txtUsername;
    Future<dynamic>? futureImage;
  var images;
  var auth = Authentication();

  Future getUserInfo() async {

   // String? uid = FirebaseAuth.instance.currentUser!.uid;

    String? uid = await Helper.getUidData();
    CollectionReference users = FirebaseFirestore.instance.collection(Database.saveFdUserTable);
    var  userData = await users.doc(uid).get();
    var data = userData.data()! as Map<String, dynamic>;
      setState(() {
       Auth profileData = Auth.fromJson(data);
        _userName.text = profileData.userName!;
        _phoneNumber.text = profileData.phoneNumber!;
        _email.text = profileData.phoneNumber!;
        _password.text = profileData.password!;
        images = profileData.profilePic!;
       // images = data['profilePic'];
    });
  }

  Future getImage(ImageSource pic) async {
    XFile? photo = await _picker.pickImage(source: pic);
    String picture = photo!.path;
    //Helper.saveImages(picture);
    String? uid = await Helper.getUidData();
    await  FirebaseStorage.instance.ref('$uid/profilePic.png').putFile(File(picture)).whenComplete((){
    }).then((fileData) async {
      await fileData.ref.getDownloadURL().then((fileUrl) async {
        await FirebaseFirestore.instance.collection(Database.saveFdUserTable).doc(uid).update({
          "profilePic" : fileUrl
        }).then((value){
          print('Data Inserted');
          setState(() {
           images = fileUrl;
           print(images);
           imageFile = File(picture);
          });
        });
        });
    });
// setState(() {
//             imageFile = File(picture);
//             images = picture;
//           });
   // Helper.saveImages(picture);

    // if (photo != null) {
    //   setState(() {
    //     imageFile = File(picture);
    //     images = picture;
    //   });
    //
    //   //getData
    // }
  }
//await FirebaseFirestore.instance.collection(Database.saveFdUserTable).add({
//           "fileUrl" :fileUrl
//         }).then((value){
//           print('Data Inserted');
//
//         });
  // Future getUserInfo() async {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   // setState(() {
  //   //   _userName.text = ;
  //   //   _phoneNumber.text = data['phoneNumber'];
  //   //   _email.text = data['email'];
  //   //   _password.text = data['password'];
  //   // });
  // }
  // Future getUserInfo() async {
  //   FirebaseFirestore.instance.collection(Database.saveFdUserTable).get().then((value){
  //     setState(() {
  //      Database.saveDataBase(_userName.text, _phoneNumber.text, _email.text, _password.text, uid: '');
  //     });
  //   });
  // }
  // File img = imageFile = File(photo!.path);
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // // prefs.setString("Img",img);
  Future getData() async {
    //images = await Helper.getImages();
   String? uid = await Helper.getUidData();
   // CollectionReference users = FirebaseFirestore.instance.collection(images).doc(uid) as CollectionReference<Object?>;
  // print(users);
   // String?  store = images;
  //  return store;
  }

  int? dropdownValue;
  readData() {
    Helper.getFriend().then((value){
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
        dropdownValue = value;
      });
    });
  }
   Future<QuerySnapshot>? future;

  @override
  void initState() {
    // TODO: implement initState
    timeInput.text;
    dateController.text = "";
    futureImage = getData();
    readData();
    getUserInfo();
  }


  final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: StyleResources.tealColor,
                  child: Column(
                    children: [
                      const Divider(color: Colors.white),
                      SizedBox(height: 22.h),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 135),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              FutureBuilder(
                                  future: futureImage,
                                  builder: (context,snapshot)
                                  {
                                    if(snapshot.connectionState == ConnectionState.done)
                                    {
                                      return SizedBox(
                                        height: 16.h,
                                        width: 31.w,
                                        child: CircleAvatar(
                                            radius: 90.h,
                                            backgroundColor: StyleResources.tealDarkColor,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(90),
                                               // child: ((images) != null) ? Image.network((images), width: 32.3.w, fit: BoxFit.cover) : Image.asset("img/appstore_icon.png",
                                                child: ((images) != null) ? Image.network((images), width: 32.3.w, fit: BoxFit.cover) : Image.asset("img/appstore_icon.png",
                                                  width: 32.3.w,
                                                  fit: BoxFit.cover,
                                                )),
                                        ),
                                      );
                                    }
                                    else
                                    {
                                      return Center(
                                        child: CircularProgressIndicator(color: StyleResources.tealColor,),
                                      );
                                    }
                                  }
                              ),
                              Positioned(
                                  right: -106,
                                  bottom: -86,
                                  left: 2,
                                  top: 0,
                                  child: SizedBox(
                                      height: 45.h,
                                      width: 90.w,
                                      child: GestureDetector(
                                        onTap: () async {
                                          AlertDialog alert = AlertDialog(
                                            title: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    getImage(ImageSource.camera);
                                                  },
                                                  child: Container(
                                                    height: 5.h,
                                                    //width: 18.h,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: StyleResources
                                                                .tealDarkColor)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.camera_alt,
                                                          color: StyleResources
                                                              .tealDarkColor,
                                                          size: 30,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(horizontal: 19),
                                                          child: Text(
                                                            "Camera",
                                                            style: TextStyle(
                                                                color: StyleResources
                                                                    .tealDarkColor,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    getImage(ImageSource.gallery);
                                                  },
                                                  child: Container(
                                                    height: 5.h,
                                                    //width: 38.h,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: StyleResources
                                                                .tealDarkColor)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.file_copy,
                                                          color: StyleResources
                                                              .tealDarkColor,
                                                          size: 30,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 19),
                                                          child: Text(
                                                            "Gallery",
                                                            style: TextStyle(
                                                                color: StyleResources
                                                                    .tealDarkColor,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 5.h,
                                                    //width: 18.h,
                                                    decoration: BoxDecoration(border: Border.all(color: StyleResources.redColor)),
                                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.cancel, color: StyleResources.redColor, size: 30,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(horizontal: 19),
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(color: StyleResources.redColor, fontSize: 20),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: Colors.white,
                                          );
                                          showDialog(context: context, builder: (BuildContext context) {return alert;});
                                        },
                                        child: const Center(
                                            child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.teal,
                                        )),
                                      ))),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
                        SafeArea(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children:  [
                                Row(
                                  children: [
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
                                            readOnly: true,
                                            enabled: false,
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
                                    var userName = _userName.text;
                                    var phoneNumber = _phoneNumber.text;
                                    var email = _email.text;
                                    var password = _password.text;

                                    // Map<String,dynamic> allData = {
                                    //   "UserName": _userName.text,
                                    //   "Phone": _phoneNumber.text,
                                    //   "Email": _email.text,
                                    //   "Password": _password.text,
                                    // };
                                  String? uid =  await Helper.getUidData();
                                    if(_formKey.currentState!.validate()){
                                        {
                                      await FirebaseFirestore.instance.collection(Database.saveFdUserTable).doc(uid).update({
                                      "userName" : userName,
                                      "phoneNumber" : phoneNumber,
                                      "password" : password,
                                      }).then((value){
                                      print('Data Inserted');
                                      });
                                          Helper.saveUserLogin(true);
                                        }
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
                                  btnTxt: "UPDATE",
                                ),
                                SizedBox(height: 1.h,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getFromGallery() async {
    XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(()  {
       imageFile = File(photo.path);

      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
      });
    }
  }
}
//DropdownButton(
//                                 hint: const Text('Please choose a Friends'),
//                                 value: dropdownValue,
//                                 onChanged: (newValue) async {
//
//                                   //SharedPreferences prefs = await SharedPreferences.getInstance();
//                                   setState(() {
//                                     dropdownValue = newValue;
//                                     Helper.saveFriend(dropdownValue!);
//                                     //prefs.setInt("ID", dropdownValue!);
//                                     print(dropdownValue);
//                                   });
//                                 },
//                                 items:  personList.map((data) {
//                                   return DropdownMenuItem(
//                                     value:  data.id,
//                                     child:  Text(data.name!),
//                                   );
//                                 }).toList(),
//                               ),