import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mlog/app/view/search_user/serch_user_viewmodel.dart';

class SearchUserView extends StatelessWidget {
  /// Users can search other users by name and email addresses
   SearchUserView({Key? key}) : super(key: key);

  final SearchViewModel viewModel = Get.put(SearchViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search users"),
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
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              spreadRadius: -9,
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 25,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child:  TextField(
          controller: viewModel.filter,
          autofocus: false,
          onTap: viewModel.searchPressed,
          decoration:  InputDecoration(
            border: InputBorder.none,
            hintText: 'Search bloggers...',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ),
    ])))));
  }
}

