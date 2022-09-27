import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../components/blog_bost_item.dart';
import '../components/custom_l_button.dart';
import 'blog_datail_view.dart';
import 'home_view_model.dart';

class HomeView extends GetView<HomeViewModel> {
  @override
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
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
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: viewModel.getRealtimeBlogPost(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.purpleAccent),
                                    ),
                                  ),
                                );
                              }
                              return ListView(
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    return BlogPostWidget(key: key, data: data);
                                  }).toList());
                            }),
                      ],
                    )))));
  }
}
