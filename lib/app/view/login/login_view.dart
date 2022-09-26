import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mlog/app/view/login/login_view_model.dart';

import '../../common/utils/utils.dart';
import '../components/custom_l_button.dart';
import '../components/custom_text_field.dart';
class LoginView extends GetView<LogingViewModel> {

  /// user Logs in to Mlog from here

  @override
  final LogingViewModel viewModel = Get.put(LogingViewModel());

    LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
          return Obx(
          () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: viewModel.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                    Text("Login", style: TextStyle(fontSize: 25.0, color: Colors.black),)
                    ],
                  ),

                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 4),
                    child: CustomTextField(
                      hintText: "Email",
                      keyboardType: TextInputType.number,
                      textController: viewModel.emailController,
                      onChanged: (v) {
                        if (v.isNotEmpty) viewModel.clearErrorEmail();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.errorEmailMessage.value,
                          style: errorTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 4),
                    child: CustomTextField(
                      hintText: "Password",
                      isPasswordField: true,
                      textController: viewModel.passwordController,
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          viewModel.errorPasswordMessage.value,
                          style: errorTextStyle,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child:  CustomButton(
                      buttonColor: const Color(0xFFE1BEE7),
                      buttonTextColor: Colors.black,
                      isLoading: viewModel.isLoading.value,
                      buttonText: "Login",
                      onPressed: () {
                        viewModel.loginFormValidator();
                      },
                    ),
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                       Text("----------OR-----------"),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child:  CustomButton(
                      buttonColor: Colors.white,
                      buttonTextColor: Colors.blue,
                      isLoading: viewModel.isLoadingGoogle.value,
                      buttonText: "Login with Google",
                      onPressed: () {
                        viewModel.loginWithGoogle();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}


