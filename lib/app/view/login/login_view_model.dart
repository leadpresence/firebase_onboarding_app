import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mlog/app/view/dashboard/dashboard.dart';

import '../../common/di/depenndencies.dart';
import '../../models/user.dart';

class LogingViewModel extends GetxController {

  final utilsProvider = Get.find<UtilsProvider>();

  RxString emailObserver = ''.obs;
  Rx<UserModel> rxUser = UserModel().obs;
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

  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await utilsProvider.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      rxUser.value = UserModel(id: userCredential.user?.uid.toString(),
          firstName: userCredential.user?.displayName,
          lastName: userCredential.user?.displayName,
          email: userCredential.user?.email,
          imageUrl: userCredential.user?.photoURL);
      navigateToHomeScreen();
      return rxUser.value ;
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
  }
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
      final authResult = await utilsProvider.auth.signInWithCredential(credential);
      final User? user = authResult.user;
      assert(user?.isAnonymous == false);
      assert(await user?.getIdToken() != null);
      final User? currentUser = utilsProvider.auth.currentUser;
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
