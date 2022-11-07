import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mlog/pages/onboarding/splash.dart';
import 'package:bot_toast/bot_toast.dart';
import 'core/core_utils.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light));
  await setDi();

  runApp(  GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: const SplashPage(),
    builder: BotToastInit(),
  ));
}
