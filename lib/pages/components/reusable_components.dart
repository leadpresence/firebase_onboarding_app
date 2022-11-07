import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/color.dart';

Widget getAppBar(String title, BuildContext context,
    {bool showActions = false, IconButton? actionIcon = null, bool showBack=true, Function? backPressed}) {
  return AppBar(
    elevation: 0,
    backgroundColor: white,
    leading: showBack?IconButton(
        onPressed: () {
          backPressed??Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: black,
          size: 22,
        )):const SizedBox(),
    title: Text(
      title,
      style: const TextStyle(fontSize: 18, color: black),
    ),
    actions: [
      showActions ? IconButton(
          onPressed: () {},
          icon: actionIcon ?? IconButton(onPressed: () {},
              icon: const Icon(Icons.more_vert, color: black, size: 25)))
              :SizedBox()
    ],
  );
}

const TextStyle errorTextStyle = TextStyle(
  fontSize: 10,
  color: Colors.deepOrange,
  // height: 1.8,
  letterSpacing: .2,
  fontWeight: FontWeight.bold,
);