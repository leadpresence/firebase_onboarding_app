import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlog/app/view/components/custom_l_button.dart';
import 'home_view_model.dart';

class BlogDetailView extends GetView<HomeViewModel> {
  Map<String, dynamic> post;

  BlogDetailView({Key? key, required this.post}) : super(key: key);
  @override
  final HomeViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(post['author'] + ' | ' + post['category']),
          backgroundColor: Colors.purpleAccent,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    top: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(
                      width: screenWidth(context),
                  height: screenWidth(context) * 0.5,
                  margin: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(post['imageLink'])),
                      borderRadius: BorderRadius.circular(5)),
                ),
                const SizedBox(height: 10,),
                Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child:  Text(
                      "Title: "+ post['title'],
                      style: const  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    const SizedBox(height: 10,),

                    Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child:  Text(
                      "Post: "+ "\n"+post['content'],
                      maxLines: 1000,
                      overflow: TextOverflow.ellipsis,
                      style:  const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    )),

                    ])))));
  }
}
