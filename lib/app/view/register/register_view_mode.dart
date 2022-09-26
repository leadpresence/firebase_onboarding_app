import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class  RegisterViewModel extends GetxController{
  final registerFormKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  RxString errorName = "".obs;
  RxString errorEmail = "".obs;
  RxString errorPassword = "".obs;
  var isLoading = false.obs;

  favFormValidator(Key? k) {
    /// validates empty fields on the form
    if ((GetUtils.isBlank(nameCtrl.text)) == true) {
      return errorName.value = '      Name field cannot be blank.';
    } else if ((GetUtils.isBlank(emailCtrl.text)) == true) {
      errorEmail.value = '      Email field cannot be blank.';
    }  else if ((GetUtils.isBlank(passwordCtrl.text)) == true) {
      errorPassword.value = '      password field cannot be blank.';
    } else {
      registerUserToMlog();
    }
  }

  registerUserToMlog() {
    ///register user to firbase db
    isLoading.value = true;
    var name = nameCtrl.text.toString();
    var email = emailCtrl.text.toString();
    var age = passwordCtrl.text.toString();
    // firebaseFirestore
    //     .collection(collectionPath)
    //     .add(FanxtarsModel(
    //             name: name,
    //             phone: phone,
    //             age: age,
    //             favorite: favorite,
    //             city: city,
    //             dateJoined: dateJoined)
    //         .toMap())
    //     .then((value) {
    //   print("User Added");
    // }).catchError((error) => print("Failed to add favorites: $error"));

    isLoading.value = false;
  }

}