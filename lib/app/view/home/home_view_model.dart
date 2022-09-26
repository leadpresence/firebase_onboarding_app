import 'package:cloud_firestore/cloud_firestore.dart';
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
    //   var result = utilsProvider.firebaseFirestore.collection(utilsProvider.collectionPath).snapshots().map(
//       (query) => query.docs
//           .map((fans) => BlogPost.fromMap(fans.data()))
//           .toList());
    try {
      var results = utilsProvider.firebaseFirestore
          .collection(utilsProvider.blogCollectionPath)
          .snapshots();
      return results;
    } catch (e) {
      return null;
    }

    return null;
  }
}
