import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mlog/app/common/di/depenndencies.dart';
import 'package:mlog/app/models/blog_post.dart';

class HomeViewModel extends GetxController {
  final utilsProvider = Get.find<UtilsProvider>();
  late DocumentSnapshot querySnapshot;

  Stream<QuerySnapshot>? getMoviesPosts() {
    Stream<QuerySnapshot> result;
    try {
      result = utilsProvider.firebaseFirestore.collection(
          utilsProvider.blogCollectionPath)
          .where('category',whereIn: ['movies'])
          .snapshots();
      if (kDebugMode) {
        print("Post::{$result}");
      }
      return result;
    } catch (e) {
      return null;
    }

  }
  Stream<QuerySnapshot>? getSportsPosts() {
    Stream<QuerySnapshot> result;
    try {
      result = utilsProvider.firebaseFirestore.collection(
          utilsProvider.blogCollectionPath)
          .where('category',whereIn: ['sports'])
          .snapshots();
      if (kDebugMode) {
        print("Post::{$result}");
      }
      return result;
    } catch (e) {
      return null;
    }

  }
  Stream<QuerySnapshot>? getRealtimeBlogPost() {
    Stream<QuerySnapshot> result;
    try {
      result = utilsProvider.firebaseFirestore.collection(
          utilsProvider.blogCollectionPath).snapshots();
      if (kDebugMode) {
        print("Post::{$result}");
      }
      return result;
    } catch (e) {
      return null;
    }

  }



@override
void onDisposed(){
    super.dispose();
}
  @override
  void onInit() async {

    getMoviesPosts();
    getSportsPosts();
    getRealtimeBlogPost();
    super.onInit();
  }



}
