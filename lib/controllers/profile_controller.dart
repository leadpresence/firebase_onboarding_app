import 'package:get/get.dart';
import '../core/core_utils.dart';

class ProfileViewModel extends GetxController {
  final utilsProvider = Get.find<UtilsProvider>();
  RxString name = "".obs;
  RxString email = "".obs;
  RxString photoUrl = "".obs;

  @override
  void onInit() async {
    getCurrentUser();
    super.onInit();
  }

  getCurrentUser() async{
    final user = utilsProvider.user;
    if (user != null) {
      // Name, email address, and profile photo URL
      name.value = user?.displayName;
      email.value = user?.email;
      photoUrl.value = user?.photoURL;
    }
  }
}
