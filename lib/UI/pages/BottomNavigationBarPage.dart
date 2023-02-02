import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widgetpractice/UI/pages/CallsPage.dart';
import 'package:widgetpractice/UI/pages/UserPage.dart';
import 'package:widgetpractice/UI/pages/DrawerPage.dart';
import 'package:widgetpractice/resources/StyleResources.dart';
import 'package:widgetpractice/services/AuthHelper.dart';
import 'package:widgetpractice/utils/constants.dart';
import 'package:widgetpractice/widgets/MyAlertDialouge.dart';

import '../../utils/helper.dart';
import 'AuthenticationPage.dart';
import 'ProfilePage.dart';
import 'TabBarPage.dart';



class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {

  List<String> appBarTxt = [
    "Home",
    "Account",
    "User",
    "Calls",
  ];
  var auth = Authentication();
  final bottomList = [
    const TabBarPage(),
     const ProfilePage(),
    const UserPage(),
    const CallsPage(),
  ];

  String? uid;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // uid = Helper.getUidData() as String?;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(appBarTxt[Constants.pageIndex],style: Theme.of(context).textTheme.headline6),
          actions: [
            IconButton(
                onPressed: () async {
                 logOutDialogue(context,'LogOut','Sure YOuWant To LogOut', (){
                   Helper.saveUserLogin(true);
                   Helper.spClean();
                   auth.fireAuthSignOut();
                   Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (BuildContext context) => const AuthenticationPage()));
                 }, 'LogOut', (){
                   Navigator.of(context).pop();
                 }, 'cancel');
                },
                icon: Icon(Icons.logout,color: StyleResources.whiteColor,)
            ),
          ],
      ),
        drawer:  const DrawerPage(),
        backgroundColor: const Color(0xffC4DFCB),
        bottomNavigationBar: BottomNavigationBar(
          key: Constants.globalKey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex:  Constants.pageIndex,
          onTap: (index)
          {
            setState(() {
              Constants.pageIndex=index;
            });
          },
        selectedItemColor: StyleResources.tealDarkColor,
        unselectedItemColor: Theme.of(context).disabledColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "User"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              label: "Calls"
          ),
        ],
      ),
        body:  bottomList[Constants.pageIndex],
    );
  }
}
