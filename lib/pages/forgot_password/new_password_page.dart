import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mlog/pages/forgot_password/reset_password_page.dart';

import '../../theme/color.dart';
import '../components/custom_large_button.dart';
import '../components/custom_text_field.dart';
import '../components/reusable_components.dart';
import '../onboarding/sign_up_page.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    TextEditingController passwordController = TextEditingController();
    TextEditingController confPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: getAppBar( "Login",context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Form(child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                child: CustomTextField(
                  showTopLabel: true,
                  topLabelText: "New Password",
                  isPasswordField: true,
                  textCapitalization: TextCapitalization.words,
                  // textController: controller.firstNameController,
                  keyboardType: TextInputType.text,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      // controller.clearErrorfirstName();
                    }
                  },
                ),
              ),
              const Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Text("",
                  // controller.errorfirstNameMessage.value,
                  style: errorTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                child: CustomTextField(
                  showTopLabel: true,
                  topLabelText: "Confirm New Password",
                  isPasswordField: true,
                  textCapitalization: TextCapitalization.words,
                  // textController: controller.firstNameController,
                  keyboardType: TextInputType.text,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      // controller.clearErrorfirstName();
                    }
                  },
                ),
              ),
              const Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Text("",
                  // controller.errorfirstNameMessage.value,
                  style: errorTextStyle,
                ),
              ),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: CustomButton(
                  // isLoading: controller.isLoading.value,
                  buttonText: "Reset",
                  onPressed: () {
                    //validate form and submit
                    // controller.signUpFormValidator(key);
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
                            builder: (context) =>   SignupPage()));
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
                            builder: (context) =>   ResetPasswordEmailPage()));
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
            ],))

          ],),
      ),
    );
  }
}
