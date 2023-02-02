import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widgetpractice/resources/StyleResources.dart';
import 'package:widgetpractice/utils/constants.dart';
import 'package:widgetpractice/utils/helper.dart';

import 'UI/pages/AuthenticationPage.dart';
import 'UI/pages/BottomNavigationBarPage.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Helper.getUserLogin().then((value){
    Constants.isLoginBool = value;
    runApp(const MyApp());
    print(value);
  });


  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.getInstance().then((prefs) {
  //   prefs.containsKey("isLogin");
  //
  //  // print(prefs);
  // });

  SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: StyleResources.tealDarkColor,
      ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GestureDetector(
          onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: StyleResources.tealColor,
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: StyleResources.tealLightColor,
              //textTheme: GoogleFonts.poppinsTextTheme(),
              textTheme:  TextTheme(
                headline1: GoogleFonts.roboto(),
                headline2: GoogleFonts.aBeeZee(),
                headline3: GoogleFonts.aBeeZee(),
                headline4: GoogleFonts.aBeeZee(),
                headline5: GoogleFonts.actor(),
                headline6: GoogleFonts.actor(color: StyleResources.whiteColor),
                subtitle1: GoogleFonts.actor(),
                subtitle2: GoogleFonts.actor(color: StyleResources.whiteColor),
                bodyText1: GoogleFonts.asul(),
                bodyText2: GoogleFonts.actor(color: StyleResources.whiteColor),
                button: GoogleFonts.actor(color: StyleResources.whiteColor,fontSize: 18),
                caption: GoogleFonts.actor(),
                overline: GoogleFonts.aBeeZee(),
              ),
             // useMaterial3: true
            ),
            home: Constants.isLoginBool! ? const BottomNavigationBarPage() : const AuthenticationPage(),
           // home:   const RoughPage(),
          ),
        );
      },
      maxTabletWidth: 900, // Optional
    );
  }

}

