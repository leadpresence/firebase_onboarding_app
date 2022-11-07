import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mlog/controllers/login_controller.dart';

import '../../theme/color.dart';
import '../components/custom_text_field.dart';
import '../components/reusable_components.dart';
import '../onboarding/login_page.dart';


/// this screen allows users to update the  email,password,username and logout

class UpdatePasswordPage extends GetView<LogingViewModel> {
  UpdatePasswordPage({Key? key}) : super(key: key);
  @override
  final LogingViewModel controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
          backgroundColor: white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: getAppBar("Update Password", context,
                showActions: true,
                actionIcon: IconButton(
                    onPressed: () {
                      //logout all signed in users
                      controller.logout();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    icon:
                    const Icon(Icons.exit_to_app, color: black, size: 25))),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 40, left: 15, right: 15),
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                        child: CustomTextField(
                          errorText: controller.errorUpdatePasswordMessage.value,
                          textController: controller.emailController,
                          showTopLabel: true,
                          isPasswordField: true,
                          topLabelText: "New Password",
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          onChanged: (v) {
                            if (v.isNotEmpty) {
                              controller.errorUpdatePasswordMessage.value = '';
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                var newPassword =
                                controller.updatePasswordController.text.toString();
                                if ((GetUtils.isBlank(
                                    controller.updatePasswordController.text)) ==
                                    true) {
                                  (controller.errorUpdatePasswordMessage.value =
                                  'New password can not be blank');
                                } else {
                                  controller.resetUserPassword(newPassword.trim(), context);
                                }
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: primary,
                                    fontWeight: FontWeight.w800),
                              ))
                        ],
                      )
                    ],
                  ),
                )),
          )),
    );
  }

}
