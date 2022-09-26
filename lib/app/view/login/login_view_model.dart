import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mlog/app/view/dashboard/dashboard.dart';

class LogingViewModel extends GetxController {
  RxString emailObserver = ''.obs;
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxString errorEmailMessage = "".obs;
  RxString errorPasswordMessage = "".obs;
  var isLoading = false.obs;
  var isLoadingGoogle = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void clearErrorEmail() => errorEmailMessage.value = '';

  void clearErrorPassword() => errorPasswordMessage.value = '';

  bool validateEmail(String str) {
    emailObserver.value = str;
    if (!emailObserver.value.contains("@")) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  loginFormValidator() {
    if ((GetUtils.isBlank(emailController.text)) == true) {
      return errorEmailMessage.value = "      Email field cannot be blank.";
    } else if (validateEmail(emailController.text.toString())) {
      "       Enter a valid email.";
    } else if ((GetUtils.isBlank(passwordController.text)) == true) {
      return errorPasswordMessage.value =
          "       Password field cannot be blank.";
    } else {
      login();
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    navigateToHomeScreen;
  }

  navigateToHomeScreen() {
    emailController.text = '';
    passwordController.text = '';
    Get.offAll(
      () => const DashboardTabs(
        tabIndex: 0,
      ),
      transition: Transition.cupertino,
    );
    isLoading.value = false;
  }

  loginWithGoogle() async {
    isLoadingGoogle.value = true;
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      assert(user?.isAnonymous == false);
      assert(await user?.getIdToken() != null);
      final User? currentUser = _auth.currentUser;
      assert(user?.uid == currentUser?.uid);
      isLoadingGoogle.value=false;
      navigateToHomeScreen(); // navigate to your wanted page
      return;
    } catch (e) {
      isLoadingGoogle.value=false;

      rethrow;
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.back(); // navigate to your wanted page after logout.
  }
}
