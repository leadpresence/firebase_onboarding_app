import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mlog/app/models/blog_post.dart';

import 'home_view_model.dart';

class BlogDetailView extends GetView<HomeViewModel> {

  BlogPost post;


   BlogDetailView({Key? key, required this.post}) : super(key: key);
  @override
  final HomeViewModel viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
