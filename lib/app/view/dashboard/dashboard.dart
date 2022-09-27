import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mlog/app/view/home/home.dart';
import 'package:mlog/app/view/new_blog/new_blog.dart';
import 'package:mlog/app/view/profile/profile.dart';
import 'package:mlog/app/view/search_user/search_user_view.dart';

class DashboardTabs extends StatefulWidget {
  /// Main screen of the app that enable navigation with tabs

  final int tabIndex;

  const DashboardTabs({Key? key,this.tabIndex =0}) : super(key: key);

  @override
  State<DashboardTabs> createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  int _currentIndex = 0;
  final List<Map<String, dynamic>> _children = [];

  @override
  void initState() {
    _children.add({
      "title": "Home",
      "widget": HomeView(),
    });
    _children.add({
      "title": "search",
      "widget":   SearchUserView(),
    });
    _children.add({
      "title": "Post",
      "widget": const NewBlogView(),
    });
    _children.add({
      "title": "Profile",
      "widget": const Profile(),
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFFAFAFB),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          selectedItemColor: const Color(0xFFE1BEE7),
          unselectedItemColor: const Color(0xff747B84),
          onTap: (int index) {
            HapticFeedback.selectionClick();
            setState(() => _currentIndex = index);
          },
          unselectedLabelStyle: TextStyle(
            height: 1.8,
            letterSpacing: .5,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: Colors.grey.withOpacity(0.5),
          ),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontSize: 10,
            letterSpacing: .5,
            color: Color(0xFFE1BEE7),
            fontWeight: FontWeight.normal,
            height: 1.8,
          ),
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/home.svg',
                color: _currentIndex == 0
                    ? const Color(0xFFE1BEE7)
                    : const Color(0xff747B84),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/search.svg',
                color: _currentIndex == 1
                    ? const Color(0xFFE1BEE7)
                    : const Color(0xff747B84),
                height: 22,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/+.svg',
                height: 21,
                color: _currentIndex == 2
                    ? const Color(0xFFE1BEE7)
                    : const Color(0xff747B84),
              ),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/user_icon.svg',
                color: _currentIndex == 3
                    ? const Color(0xFFE1BEE7)
                    : const Color(0xff747B84),
              ),
              label: 'Profile',
            ),

          ],
        ),
      ),
      body: _children.length >= 2
          ? _children[_currentIndex]['widget']
          : Container(),
    );

  }
}
