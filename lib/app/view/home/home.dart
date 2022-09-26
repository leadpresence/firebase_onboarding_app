import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mlog/app/models/blog_post.dart';

import '../components/blog_bost_item.dart';
import 'home_view_model.dart';

class HomeView extends GetView<HomeViewModel> {
  @override
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 2.0,
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: viewModel.getRealtimeBlogPost(),
                        builder: (context, snapshot) {
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
                          return BuildUI();
                          // ]),
                        })))));
  }
}

class BuildUI extends StatelessWidget {
  final HomeViewModel viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: viewModel.getRealtimeBlogPost(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return  const Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child:CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
              ),
            ),
          );
        }
        return BuildFeedList(snapshot.data?.docs as List<DocumentSnapshot>,key: key,);
      },
    );
  }
}

class BuildFeedList extends StatelessWidget {
  final List<DocumentSnapshot> snapshot;

  const BuildFeedList(this.snapshot, {super.key});

  @override
  Widget build(BuildContext context) {
    return snapshot.isNotEmpty
        ? Column(children: [
      for (var data in snapshot.reversed.toList())
            BlogPostWidget(data: data, key: key!!)
    ])
        : Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height:30),
          Opacity(
            opacity: 0.5,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://media.istockphoto.com/vectors/box-icon-thin-line-for-web-and-mobile-modern-minimalistic-flat-design-vector-id1048161522?s=612x612',
                          scale: 3))),
            ),
          ),
          const SizedBox(height:20),
          const Text('No Posts'),
        ],
      ),
    );
  }
}
