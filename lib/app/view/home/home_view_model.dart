import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mlog/app/common/di/depenndencies.dart';
import 'package:mlog/app/models/blog_post.dart';

class HomeViewModel extends GetxController {
  final utilsProvider = Get.find<UtilsProvider>();
  late DocumentSnapshot querySnapshot;

  Future<List<BlogPost>> getBlogPost() async {
    try {} catch (e) {}
    return [];
  }

  Stream<QuerySnapshot>? getRealtimeBlogPost() {
    Stream<QuerySnapshot> result;
    //   (query) => query.docs
    //       .map((fans) => BlogPost.fromMap(fans.data()))
    //       .toList());
    try {
      result = utilsProvider.firebaseFirestore.collection(
          utilsProvider.blogCollectionPath).snapshots();

      // var results = utilsProvider.firebaseFirestore
      //     .collection(utilsProvider.blogCollectionPath)
      //     .snapshots();
      if (kDebugMode) {

        print("Post::{$result}");
      }
      return result;
    } catch (e) {
      return null;
    }

  }

  final posts = <BlogPost>[].obs;

  @override
  void onInit() async {
    getRealtimeBlogPost();
    super.onInit();
  }



}
