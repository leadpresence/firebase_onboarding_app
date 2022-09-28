import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mlog/app/view/login/login_view.dart';

import '../../common/di/depenndencies.dart';
import '../../models/user.dart';

class RegisterViewModel extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  final utilsProvider = Get.find<UtilsProvider>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  RxString errorName = "".obs;
  RxString errorEmail = "".obs;
  RxString errorPassword = "".obs;
  var isLoading = false.obs;

  Rx<UserModel> rxUser = UserModel().obs;

  registrationFormValidator(Key? k) {
    /// validates empty fields on the form
    if ((GetUtils.isBlank(nameCtrl.text)) == true) {
      return errorName.value = '      Name field cannot be blank.';
    } else if ((GetUtils.isBlank(emailCtrl.text)) == true) {
      errorEmail.value = '      Email field cannot be blank.';
    } else if ((GetUtils.isBlank(passwordCtrl.text)) == true) {
      errorPassword.value = '      password field cannot be blank.';
    } else {
      createUserWithEmailAndPassword();
    }
  }



  Future<UserModel?> createUserWithEmailAndPassword() async {
    isLoading.value = true;
    var name = nameCtrl.text.toString();
    var email = emailCtrl.text.toString();
    var password = passwordCtrl.text.toString();
    try {
      final userCredential =
      await utilsProvider.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading.value = false;

      rxUser.value = UserModel(
          id: userCredential.user?.uid.toString(),
          firstName: userCredential.user?.displayName,
          lastName: userCredential.user?.displayName,
          email: userCredential.user?.email,
          imageUrl: userCredential.user?.photoURL);
      Get.to(() => LoginView());
      return rxUser.value;
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
