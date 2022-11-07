import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlog/controllers/login_controller.dart';
import 'package:mlog/pages/update_profile/update_email.dart';
import 'package:mlog/pages/update_profile/update_password.dart';
import 'package:mlog/pages/update_profile/update_username.dart';
import '../theme/color.dart';
import 'components/reusable_components.dart';
import 'onboarding/login_page.dart';

/// this screen allows users to update the  email,password,username and logout

class SettingsPage extends GetView<LogingViewModel> {
  SettingsPage({Key? key}) : super(key: key);
  @override
  final LogingViewModel controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getSignedInUserDetails();
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: getAppBar("Settings", context,
            showActions: true,
            actionIcon: IconButton(
                onPressed: () {
                  //logout all signed in users
                  controller.logout();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                icon: const Icon(Icons.exit_to_app, color: black, size: 25))),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 25, bottom: 40, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Account settings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                controller.detailEditCaseString.value ='Username';
                Get.to(UpdateUsernamePage());
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 10,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Update Username",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Get.to(UpdatePasswordPage());
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 10,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                controller.detailEditCaseString.value ='Email';
                Get.to(UpdateEmailPage());
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 10,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Update Email",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      )),
    );
  }
}
