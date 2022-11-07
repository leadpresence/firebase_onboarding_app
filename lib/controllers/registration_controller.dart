import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../core/core_utils.dart';
import '../models/user_model.dart';
import '../pages/onboarding/auth_main_page.dart';

class RegisterViewModel extends GetxController {
  final registerFormKey = GlobalKey();
  final utilsProvider = Get.find<UtilsProvider>();

  final userNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confPasswordCtrl = TextEditingController();
  RxString userEmail = "".obs;
  RxString errorUserName = "".obs;
  RxString errorEmail = "".obs;
  RxString errorPassword = "".obs;
  RxString errorConfPassword = "".obs;
  var isLoading = false.obs;
  /// List of interests to choose from
  List<String> defaultInterests = [
    "Football",
    "Cricket",
    "Rugby",
    "Skating",
    "Sky-diving",
    "Snooker",
    "Basketball"
  ];
  ///User selected interest
  Rx<List<String>> selectedInterestsList = Rx<List<String>>([]);

  Rx<UserModel> rxUser = UserModel().obs;

  registrationFormValidator(Key? k) {
    /// validates empty fields on the form
    if ((GetUtils.isBlank(userNameCtrl.text)) == true) {
      return errorUserName.value = '      User name field cannot be blank.';
    } else if ((GetUtils.isBlank(emailCtrl.text)) == true) {
      errorEmail.value = '      Email field cannot be blank.';
    } else if ((GetUtils.isBlank(passwordCtrl.text)) == true) {
      errorPassword.value = '      password field cannot be blank.';
    } else if ((GetUtils.isBlank(confPasswordCtrl.text)) == true) {
      errorConfPassword.value =
          '      password confirmation field cannot be blank.';
    } else if (confPasswordCtrl.text.toString().trim() !=
        passwordCtrl.text.toString().trim()) {
      errorConfPassword.value = '      Password does not match.';
    } else {
      createUserWithEmailAndPassword();
    }
  }

  Future<UserModel?> createUserWithEmailAndPassword() async {
    isLoading.value = true;
    var name = userNameCtrl.text.toString().trim();
    var email = emailCtrl.text.toString().trim();
    var password = passwordCtrl.text.toString().trim();
    try {
      final userCredential =
          await utilsProvider.auth.createUserWithEmailAndPassword(email: email,
        password: password,
      );

      isLoading.value = false;
      /// store user
      // saveUserData(name, email);
      saveUserName(name);
      BotToast.showText(text: "Registration successful,please verify account from \n email $email (check Spam too)");
      Get.to(() => AuthMainPage());
      clearRegForm();
      return rxUser.value;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        BotToast.showText(text:'The password chosen is weak');
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        BotToast.showText(text:'The account already exists for that email.');
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      isLoading.value = false;
      BotToast.showText(text:'An error occurred check connect and try again \n ${e.toString()}');

      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  saveUserData(String email){
    // GetStorage().write("username", username);
    GetStorage().write("email", email);
  }

  Future saveUserName(String username) async {
    var message;
    try {
      var firebaseUser = utilsProvider.auth.currentUser!;
      firebaseUser
          .updateDisplayName(username)
          .then(
            (value) => message = 'Success',
      )
          .catchError((onError) => message = 'error');
      return message;
    } catch (e) {}
  }

  clearRegForm() {
    userNameCtrl.text = '';
    emailCtrl.text = '';
    passwordCtrl.text = '';
    confPasswordCtrl.text = '';
    confPasswordCtrl.text = '';
  }




  Future sendEmailVerification() async {
    var user = utilsProvider.auth.currentUser;
    user?.sendEmailVerification();
  }
}
