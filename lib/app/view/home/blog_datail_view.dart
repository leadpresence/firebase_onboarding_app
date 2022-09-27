import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mlog/app/models/blog_post.dart';

import 'home_view_model.dart';

class BlogDetailView extends GetView<HomeViewModel> {

  Map<String, dynamic> post;


   BlogDetailView({Key? key, required this.post}) : super(key: key);
  @override
  final HomeViewModel viewModel = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
