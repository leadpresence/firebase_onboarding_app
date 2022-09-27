import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mlog/app/view/components/custom_l_button.dart';

import '../components/blog_bost_item.dart';
import 'home_view_model.dart';

class HomeView extends GetView<HomeViewModel> {
  @override
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                          TabBar(
                              unselectedLabelColor: const Color(0xff747B84),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color(0xFFE1BEE7)),
                              tabs: [
                                Tab(
                                    child: Container(
                                        height: screenWidth(context)*0.25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: const Color(0xFFE1BEE7),
                                                width: 1)),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'All',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ))),
                                Tab(
                                    child: Container(
                                        height: screenWidth(context)*0.25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: const Color(0xFFE1BEE7),
                                                width: 1)),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Movies',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ))),
                                Tab(
                                    child: Container(
                                      height: screenWidth(context)*0.25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: const Color(0xFFE1BEE7),
                                                width: 1)),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Sports',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ))),
                              ]),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: Get.height * 0.7,
                            child: TabBarView(children: [
                              allNews(),
                              moviesNews(),
                              sportsNews()
                            ]),
                          )
                        ],
                      ))))),
    );
  }

  Widget allNews() {
    return StreamBuilder<QuerySnapshot>(
        stream: viewModel.getRealtimeBlogPost(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
                ),
              ),
            );
          }
          return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return BlogPostWidget(key: key, data: data);
              }).toList());
        });
  }
  Widget moviesNews() {
    return StreamBuilder<QuerySnapshot>(
        stream: viewModel.getMoviesPosts(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
                ),
              ),
            );
          }
          return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
               // var moviesMap = data.entries.where((element) => element.value=="movies");

                return BlogPostWidget(key: key, data: data);
              }).toList());
        });
  }
  Widget sportsNews() {
    return StreamBuilder<QuerySnapshot>(
        stream: viewModel.getSportsPosts(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
                ),
              ),
            );
          }
          return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                // var sportsMap = data.entries.where((element) => element.value=="sports");

                return BlogPostWidget(key: key, data: data);
              }).toList());
        });
  }
}
