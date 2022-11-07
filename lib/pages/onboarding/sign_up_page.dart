import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/registration_controller.dart';
import '../../theme/color.dart';
import '../components/custom_large_button.dart';
import '../components/custom_text_field.dart';
import '../components/mutli_select_chip.dart';
import '../components/reusable_components.dart';
import 'login_page.dart';

/// Sign up page to create account with username email & password and user interests
class SignupPage extends GetView<RegisterViewModel> {
  SignupPage({Key? key}) : super(key: key);

  @override
  final RegisterViewModel controller = Get.put(RegisterViewModel());

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Obx(
      () => BlurryModalProgressHUD(
        inAsyncCall: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: getAppBar("Register", context),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: controller.registerFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                          child: CustomTextField(
                            textController: controller.userNameCtrl,
                            errorText: controller.errorUserName.value,
                            showTopLabel: true,
                            topLabelText: "Username",
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            onChanged: (v) {
                              if (v.isNotEmpty) {
                                controller.errorUserName.value = '';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 5, 24, 4),
                          child: SizedBox(
                            width: deviceSize.width - 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    child: Chip(
                                      label: const Text("My Interests"),
                                      elevation: 2,
                                      backgroundColor: primary.withOpacity(0.6),
                                    ),
                                    onTap: () {
                                      //Show dialog here
                                      _showReportDialog(context);
                                    }),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: deviceSize.width / 2 ,

                                  child: Text(
                                    controller.selectedInterestsList.value
                                        .join(" , "),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 10, 24, 4),
                          child: CustomTextField(
                            textController: controller.emailCtrl,
                            errorText: controller.errorEmail.value,
                            showTopLabel: true,
                            topLabelText: "Email",
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            onChanged: (v) {
                              if (v.isNotEmpty) {
                                controller.errorEmail.value = '';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 10, 24, 4),
                          child: CustomTextField(
                            errorText: controller.errorPassword.value,
                            textController: controller.passwordCtrl,
                            showTopLabel: true,
                            topLabelText: "Password",
                            isPasswordField: true,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            onChanged: (v) {
                              if (v.isNotEmpty) {
                                controller.errorPassword.value = '';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                          child: CustomTextField(
                            textController: controller.confPasswordCtrl,
                            errorText: controller.errorConfPassword.value,
                            showTopLabel: true,
                            topLabelText: "Confirm Password",
                            isPasswordField: true,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            onChanged: (v) {
                              if (v.isNotEmpty) {
                                controller.errorConfPassword.value = '';
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                          child: CustomButton(
                            buttonText: "Complete registration",
                            onPressed: () {
                              //validate form and submit
                              GetStorage().write("username",
                                  controller.userNameCtrl.text.toString());
                              controller.registrationFormValidator(key);
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
                                  color:
                                      const Color(0xff12121D).withOpacity(.6),
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
      ),
    );
  }

  saveListWithGetStorage(String storageKey, List<dynamic> storageValue) async =>
      await GetStorage().write(storageKey, storageValue);

  _showReportDialog(BuildContext context) {
    List<String> temporarySelection = [];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: const Text("Select Interest(s)"),
            content: MultiSelectChip(
              controller.defaultInterests,
              onSelectionChanged: (selectedList) {
                temporarySelection = selectedList;
              },
              maxSelection: 4,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Save"),
                onPressed: () {
                  controller.selectedInterestsList.value = temporarySelection;
                  saveListWithGetStorage('interests', temporarySelection);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
