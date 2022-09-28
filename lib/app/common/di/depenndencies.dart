import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class UtilsProvider extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  get user => auth.currentUser;
   String blogCollectionPath = "MBlogPosts";
}


Future<void> setDi() async {

  /// initializes and injects providers eg auth services, blog services
  /// firebase
  await Firebase.initializeApp();
  Get.lazyPut<UtilsProvider>(() => UtilsProvider());

}