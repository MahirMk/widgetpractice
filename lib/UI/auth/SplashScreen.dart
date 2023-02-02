import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../pages/AuthenticationPage.dart';
import '../pages/BottomNavigationBarPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkLogin(context) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("isLogin")) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const BottomNavigationBarPage()));
    }
    else
      {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => const AuthenticationPage()));
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // checkLogin();
    Future.delayed(const Duration(milliseconds: 1000), () {
      checkLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        color: Colors.teal.shade100,
        child: Center(
          child: Image.asset("img/appstore_icon.png",width: 300,),
        ),
      ),
    );
  }
}
