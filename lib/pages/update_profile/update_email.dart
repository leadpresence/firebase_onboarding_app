import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mlog/controllers/login_controller.dart';

import '../../theme/color.dart';
import '../components/custom_text_field.dart';
import '../components/reusable_components.dart';
import '../onboarding/login_page.dart';

/// this screen allows users to update the  email,password,username and logout

class UpdateEmailPage extends GetView<LogingViewModel> {
  UpdateEmailPage({Key? key}) : super(key: key);
  @override
  final LogingViewModel controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: getAppBar("Update Email", context,
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                      child: CustomTextField(
                        errorText: controller.errorUpdateEmailMessage.value,
                        textController: controller.updateEmailController,
                        showTopLabel: true,
                        topLabelText: "New Email",
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        onChanged: (v) {
                          if (v.isNotEmpty) {
                            controller.errorUpdateEmailMessage.value = '';
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              var newEmail = controller
                                  .updateEmailController.text
                                  .toString();
                              debugPrint(newEmail);
                              if (controller.validateEmail(newEmail)) {
                                controller.resetEmail(newEmail, context);
                              } else {
                                (controller.errorUpdateEmailMessage.value =
                                    'Enter valid email');
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
                )),
          )),
    );
  }
}
