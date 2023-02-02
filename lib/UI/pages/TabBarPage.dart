import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:widgetpractice/UI/pages/AccountPage.dart';
import 'package:widgetpractice/UI/pages/FavoritesPage.dart';
import 'package:widgetpractice/UI/pages/HomePage.dart';
import 'package:widgetpractice/UI/pages/UserPage.dart';

import 'CallsPage.dart';
import 'ProfilePage.dart';



class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom:  PreferredSize(
            preferredSize: Size(1.w,4.h),
            child:  TabBar(
              //isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs:  [
                const Tab(
                  icon: Icon(Icons.home),
                  child: Text("Home"),
                ),
                const Tab(
                  icon: Icon(Icons.currency_rupee_outlined),
                  child: Text("Account"),
                ),
                Tab(
                  icon: Icon(Icons.favorite,color: Colors.red.shade700,),
                  child: const Text("Favorites"),
                ),
              ],
            ),
          ),
        ),
        body:  const TabBarView(
          children: [
            HomePage(),
            AccountPage(),
            FavoritesPage()
          ],
        ),
      ),
    );
  }
}
