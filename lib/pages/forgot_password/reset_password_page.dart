import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/login_controller.dart';
import '../../theme/color.dart';
import '../components/custom_large_button.dart';
import '../components/custom_text_field.dart';
import '../components/reusable_components.dart';
import '../onboarding/login_page.dart';

class ResetPasswordEmailPage extends GetView<LogingViewModel> {
  ResetPasswordEmailPage({Key? key}) : super(key: key);
  @override
  final LogingViewModel controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Obx(() => BlurryModalProgressHUD(
          inAsyncCall: controller.isResetLoading.value,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: getAppBar("Forgot Password", context),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                        child: CustomTextField(
                          textController: controller.emailResetController,
                          showTopLabel: true,
                          errorText: controller.errorResetEmailMessage.value,
                          topLabelText: "Email",
                          textCapitalization: TextCapitalization.words,
                          // textController: controller.firstNameController,
                          keyboardType: TextInputType.text,
                          onChanged: (v) {
                            if (v.isNotEmpty) {
                              controller.errorResetEmailMessage.value = '';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        child: CustomButton(
                          buttonText: "Send reset Link",
                          onPressed: () {
                            //validate form and submit
                            controller.resetEmailFormValidator(context,key);

                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        width: deviceSize.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have an account?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 17,
                                color: const Color(0xff12121D).withOpacity(.6),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.mulish(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
