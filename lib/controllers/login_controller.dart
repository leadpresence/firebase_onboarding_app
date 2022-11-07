import 'package:bot_toast/bot_toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../core/core_utils.dart';
import '../models/user_model.dart';
import '../pages/root_app.dart';

class LogingViewModel extends GetxController {
  final utilsProvider = Get.find<UtilsProvider>();

  RxString emailObserver = ''.obs;
  Rx<UserModel> rxUser = UserModel().obs;
  final loginFormKey = GlobalKey();

  // [login] [update] [reset] fields controllers
  final emailController = TextEditingController();
  final emailResetController = TextEditingController();
  final passwordController = TextEditingController();
  final updateEmailController = TextEditingController();
  final updateUsernameController = TextEditingController();
  final updatePasswordController = TextEditingController();

  // Observable Strings and  Booleans
  RxString errorEmailMessage = "".obs;
  RxString errorResetEmailMessage = "".obs;
  RxString errorPasswordMessage = "".obs;
  RxString errorUsernameMsg = "".obs;
  RxString errorUpdateEmailMessage = "".obs;
  RxString errorUpdatePasswordMessage = "".obs;
  var isLoading = false.obs;
  var isResetLoading = false.obs;
  var canNavigateToLogin = false.obs;
  var showResetLinkSnack = false.obs;
  var detailEditCaseString = "".obs;

  /// email validation
  bool validateEmail(String str) {
    if (!EmailValidator.validate(str.trim())) {
      return false;
    }
    return true;
  }

  loginFormValidator() {
    if ((GetUtils.isBlank(emailController.text)) == true) {
      return errorEmailMessage.value = "      Email field cannot be blank.";
    } else if (!validateEmail(emailController.text.toString())) {
      "       Enter a valid email.";
    } else if ((GetUtils.isBlank(passwordController.text)) == true) {
      return errorPasswordMessage.value = "    Password field cannot be blank.";
    } else {
      var email = emailController.text.toString().trim();
      var pass = passwordController.text.toString().trim();
      signInWithEmailAndPassword(email: email, password: pass);
    }
  }

  resetEmailFormValidator(BuildContext context, Key? key) {
    if ((GetUtils.isBlank(emailResetController.text)) == true) {
      return errorResetEmailMessage.value =
          "      Email field cannot be blank.";
    } else if (validateEmail(emailResetController.text.toString())) {
      "       Enter a valid email.";
    } else {
      var email = emailResetController.text.toString().trim();
      sendResetPasswordLink(email, context, key);
    }
  }

  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final userCredential =
          await utilsProvider.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      isLoading.value = false;
      GetStorage().write('email', email);
      navigateToHomeScreen();
      return rxUser.value;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        BotToast.showText(text: "User with email not not found ");
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        BotToast.showText(text: "Wrong password ");
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
    }
    return null;
  }

  /// To change user email
  Future<String> resetEmail(String newEmail, BuildContext context) async {
    var message;
    try {
      var firebaseUser = utilsProvider.auth.currentUser!;
      firebaseUser.updateEmail(newEmail).then(
        (value) {
          message = 'Success';
          BotToast.showText(text: "Email updated successfully");
        },
      ).catchError((onError) {
        message = 'error';
        BotToast.showText(
            text: "Error occurred updating email \n ${onError.toString()}");

      });

      return message;
    } catch (e) {
      BotToast.showText(
          text: "Error occurred updating email \n ${e.toString()}");
    }
    return '';
  }

  Future resetUserName(String username, BuildContext context) async {
    var message;
    try {
      var firebaseUser = utilsProvider.auth.currentUser!;
      firebaseUser.updateDisplayName(username).then((value) {
        message = 'Success';
        GetStorage().write('username', username);
        BotToast.showText(text: "Username updated successfully");
      }).catchError((onError) {
        message = 'error';
        BotToast.showText(
            text: "Error occurred updating Username \n ${onError.toString()}");

      });
      return message;
    } catch (e) {
      BotToast.showText(
          text: "Error occurred updating Username \n ${e.toString()}");
    }
  }

  Future resetUserPassword(String password, BuildContext context) async {
    var message;
    try {
      var firebaseUser = utilsProvider.auth.currentUser!;
      firebaseUser.updatePassword(password).then(
        (value) {
          message = 'Success';
          BotToast.showText(text: "Password updated successfully");
        },
      ).catchError((onError) {
        message = 'error';
        BotToast.showText(
            text: "Error occurred updating Password \n ${onError.toString()}");
      });
      return message;
    } catch (e) {
      BotToast.showText(
          text: "Error occurred updating Password \n ${e.toString()}");
    }
  }

  navigateToHomeScreen() {
    emailController.text = '';
    passwordController.text = '';
    Get.offAll(
      () => const RootApp(),
      transition: Transition.cupertino,
    );
    isLoading.value = false;
  }

  /// To send reset password link to user
  Future sendResetPasswordLink(
      String email, BuildContext context, Key? key) async {
    isResetLoading.value = true;
    try {
      await utilsProvider.auth.sendPasswordResetEmail(email: email.trim());

      /// hide loading
      isResetLoading.value = false;
      BotToast.showText(
          text:
              "Reset password email sent successfully \n [Ensure to check spam folder]");
      Get.back();
    } on FirebaseAuthException catch (e) {
      isResetLoading.value = false;
      BotToast.showText(
          text:
              "An Error occurred sending reset password email \n ${e.toString()}");
    }
  }

  Future getSignedInUserDetails() async {
    var user = utilsProvider.auth.currentUser;
    updateEmailController.text = user!.email!.toString();
    updateUsernameController.text = GetStorage().read('username');
    if (kDebugMode) {
      print("email:${user!.email!.toString()}");
    }
  }

  Future<void> logout() async {
    await utilsProvider.auth.signOut();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailResetController.dispose();
    super.dispose();
  }
}
