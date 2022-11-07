import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mlog/pages/onboarding/sign_up_page.dart';
import '../../controllers/login_controller.dart';
import '../../theme/color.dart';
import '../components/custom_large_button.dart';
import '../components/custom_text_field.dart';
import '../components/reusable_components.dart';
import '../forgot_password/reset_password_page.dart';

class LoginPage extends GetView<LogingViewModel> {
  LoginPage({Key? key}) : super(key: key);
  @override
  final LogingViewModel controller = Get.put(LogingViewModel());

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Obx(() => BlurryModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: getAppBar("Login",  context,backPressed:(){
                if(Navigator.of(context).canPop()){
                  Get.back();

                }
              } ,showBack: false ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: controller.loginFormKey,
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                        child: CustomTextField(
                          errorText: controller.errorEmailMessage.value,
                          textController: controller.emailController,
                          showTopLabel: true,
                          topLabelText: "Email",
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          onChanged: (v) {
                            if (v.isNotEmpty) {
                              controller.errorEmailMessage.value = '';
                            }
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 15, 24, 4),
                        child: CustomTextField(
                          textController: controller.passwordController,
                          errorText: controller.errorPasswordMessage.value,
                          showTopLabel: true,
                          topLabelText: "Password",
                          isPasswordField: true,
                          textCapitalization: TextCapitalization.words,
                          // textController: controller.firstNameController,
                          keyboardType: TextInputType.text,
                          onChanged: (v) {
                            if (v.isNotEmpty) {
                              controller.errorPasswordMessage.value='';
                            }
                          },
                        ),
                      ),

                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        child: CustomButton(
                          // isLoading: controller.isLoading.value,
                          buttonText: "Login",
                          onPressed: () {
                            controller.loginFormValidator();
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
                              'Don\'t have an account?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 17,
                                color: const Color(0xff12121D).withOpacity(.6),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Register',
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        width: deviceSize.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Forgot Password?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mulish(
                                fontSize: 17,
                                color: const Color(0xff12121D).withOpacity(.6),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                          ResetPasswordEmailPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Reset Now',
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
