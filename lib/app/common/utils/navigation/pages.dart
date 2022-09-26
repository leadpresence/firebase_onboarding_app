import 'package:get/get.dart';
import 'package:mlog/app/view/dashboard/dashboard.dart';
import 'package:mlog/app/view/home/home.dart';
import 'package:mlog/app/view/login/login_view.dart';
import 'package:mlog/app/view/profile/profile.dart';
import 'package:mlog/app/view/register/register_view.dart';
import 'package:mlog/app/view/search_user/search_user_view.dart';

import '../../../view/new_blog/new_blog.dart';

class AppPages {
  AppPages._();
  static const initial = MlogRoutes.login;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () =>  HomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () =>  DashboardTabs(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.login,
      page: () =>  LoginView(),
      transition: Transition.fadeIn,
    ), GetPage(
      name: _Paths.register,
      page: () =>  RegisterView(),
      transition: Transition.fadeIn,
    ), GetPage(
      name: _Paths.profile,
      page: () =>  Profile(),
      transition: Transition.fadeIn,
    ), GetPage(
      name: _Paths.newPost,
      page: () =>  NewBlogView(),
      transition: Transition.fadeIn,
    ),GetPage(
      name: _Paths.searchUser,
      page: () =>  SearchUserView(),
      transition: Transition.fadeIn,
    ),
  ];
}

abstract class MlogRoutes {
  MlogRoutes._();
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const dashboard = _Paths.dashboard;
  static const register = _Paths.register;
  static const newPost = _Paths.newPost;
  static const profile = _Paths.profile;
  static const searchUser = _Paths.searchUser;
}

abstract class _Paths {
  static const home = '/home';
  static const dashboard = '/dashboard';
  static const login = '/login';
  static const newPost = '/newPost';
  static const register = '/register';
  static const profile = '/profile';
  static const searchUser = '/searchUser';
}