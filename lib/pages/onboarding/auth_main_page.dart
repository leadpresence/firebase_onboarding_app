import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlog/controllers/registration_controller.dart';
import 'package:mlog/pages/onboarding/login_page.dart';
import 'package:mlog/pages/onboarding/verify_email_page.dart';
import 'package:mlog/pages/root_app.dart';

class AuthMainPage extends GetView<RegisterViewModel> {
    AuthMainPage({Key? key}) : super(key: key);
  @override
  final RegisterViewModel controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: controller.utilsProvider.auth.authStateChanges(),
        builder: (ctx,snapShot){
           if(snapShot.hasData){
              return VerifyEmailPage(key: key,);
           }else{
             return LoginPage(key: key,);
           }
        },
      ),
    );
  }
}
