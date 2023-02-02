import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widgetpractice/utils/constants.dart';
import '../../resources/StyleResources.dart';
import '../../services/database.dart';
import '../../utils/helper.dart';
import '../../widgets/MyPrimaryButton.dart';
class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage>{

  File? imageFile;
  late Future<dynamic> futureImage;
  var images;
  Future getUserInfo() async {
    String? uid = await Helper.getUidData();
    CollectionReference users = FirebaseFirestore.instance.collection(Database.saveFdUserTable);
    var  userData = await users.doc(uid).get();
    var data = userData.data()! as Map<String, dynamic>;
    setState(() {
      images = data['profilePic'];
    });
  }

  Future getData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // images = prefs.getString("Img");
    // String store = images;
   // return store;
  }
  @override
  void initState() {
    // TODO: implement initState
    futureImage = getData();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 30.h,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.teal,),
              child: Column(
                children:  [
                  SizedBox(height: 3.h),
                SafeArea(
                  child: FutureBuilder(
                      future: futureImage,
                      builder: (context,snapshot)
                      {
                        if(snapshot.connectionState == ConnectionState.done)
                        {
                          return SizedBox(
                            height: 12.h,
                            width: 27.w,
                            child: CircleAvatar(
                                radius: 90.h,
                                backgroundColor: StyleResources.tealDarkColor,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    child:  ((images) != null) ? Image.network((images), width: 32.3.w, fit: BoxFit.cover) : Image.asset("img/appstore_icon.png",
                                      width: 32.3.w,
                                      fit: BoxFit.cover,
                                    ))
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
                ),
                  SizedBox(height: 1.h),
                  const Text("Mahir Kangda",style: TextStyle(color: Colors.white),),
                  SizedBox(height: 2.h),
                  SizedBox(
                    child: MyPrimaryButton(
                      //btncolor: Colors.white,
                        onClick: (){
                           setState(() {
                             setState(() {
                               Navigator.of(context).pop();
                               BottomNavigationBar navigationBar =  Constants.globalKey.currentWidget as BottomNavigationBar;
                               navigationBar.onTap!(1);
                             });
                           });
                        },
                        btnTxt: "Profile"
                    )
                    ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_none,color: StyleResources.tealDarkColor,size: 30,
            ),
            title: Text('Notification',style: TextStyle( color: StyleResources.tealDarkColor),),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:  Icon(
              Icons.settings,color: StyleResources.tealDarkColor,size: 30,
            ),
            title: Text('Setting',style: TextStyle(color: StyleResources.tealDarkColor),),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:  Icon(
              Icons.language,color: StyleResources.tealDarkColor,size: 30,
            ),
            title: Text('Language',style: TextStyle( color: StyleResources.tealDarkColor),),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info, color: StyleResources.tealDarkColor,size: 30,
            ),
            title:  Text('About',style: TextStyle( color: StyleResources.tealDarkColor),),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:  Icon(
              Icons.logout,color: StyleResources.tealDarkColor,size: 30,
            ),
            title: Text('Logout',style: TextStyle( color: StyleResources.tealDarkColor),),
            onTap: () {
              Navigator.pop(context);
            },
          ),
              Column(
                children: [
                  SizedBox(height: 13.h,),
                  const Divider(
                    color: Colors.black
                ),
                  Text('mtzInfotech \n    Nanpura',style: TextStyle(color:  StyleResources.tealDarkColor,fontSize: 17)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Icon(Icons.phone,color: StyleResources.tealDarkColor,),
                      ),
                      Text('9876543210',style: TextStyle(color: StyleResources.tealDarkColor,)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Icon(Icons.message,color: StyleResources.tealDarkColor,),
                      ),
                      Text('support@mk.com',style: TextStyle(color: StyleResources.tealDarkColor,)),
                    ],
                  ),
                  Text('  App Version: 6.0.5',style: TextStyle(color: StyleResources.tealDarkColor,)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Image.asset("img/facebook.png",height: 4.h,),
                      ),
                      Image.asset("img/instagram.png",height: 4.h,),
                    ],
                  )
                ],
              ),
         ],
      ),
    );
  }
}
