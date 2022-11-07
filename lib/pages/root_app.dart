import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mlog/pages/profile_page.dart';
import 'package:mlog/pages/settings_page.dart';

import '../theme/color.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        bottomNavigationBar: getFooter(),
        body: getBody(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              selectedTab(0);
            },
            child: const Icon(
              Icons.games_outlined,
              size: 25,
            ),
            backgroundColor: primary
            //params
            ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        // DashbaordPage(),
        Center(
          child: Text("Buddies ",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
        ),
        Center(
          child: Text(
            "Discover",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SettingsPage(),
        ProfilePage()
      ],
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
     Icons.supervised_user_circle_sharp,
   Icons.location_searching,
  Icons.settings,
     Icons.account_circle,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
