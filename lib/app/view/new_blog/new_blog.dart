import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mlog/app/view/new_blog/new_blog_view_model.dart';

import '../../common/utils/utils.dart';
import '../components/custom_l_button.dart';
import '../components/custom_text_field.dart';

class NewBlogView extends GetView<NewBlogPostViewModel> {
  /// Creates new blog  by the logged in user
  NewBlogView({Key? key}) : super(key: key);
  final NewBlogPostViewModel viewModel = Get.put(NewBlogPostViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(()
      => Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Form(
                      key: viewModel.creatNewPostFormKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Gap(24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Create your post",
                                  style: TextStyle(
                                      fontSize: 25.0, color: Colors.black),
                                )
                              ],
                            ),
                            const Gap(20),
                            ElevatedButton.icon(
                              onPressed: () {
                                viewModel.pickImage(context);
                              },
                              icon: const Icon(
                                Icons.image,
                                size: 24.0,
                              ),
                              label: const Text('Post header image'), // <-- Text
                            ),
                            const Gap(20),
                            Container(
                              width: screenWidth(context),
                              height: screenWidth(context) * 0.5,
                              margin: const EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(viewModel.imageDownloadUrl.value.toString())),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            const Gap(20),

                            const Gap(20),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 4),
                              child: CustomTextField(
                                hintText: "Author name",
                                keyboardType: TextInputType.text,
                                textController: viewModel.authorNameCtrl,
                                onChanged: (v) {
                                  if (v.isNotEmpty) viewModel.errorName();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    viewModel.errorName.value,
                                    style: errorTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 4),
                              child: CustomTextField(
                                hintText: "Post title",
                                keyboardType: TextInputType.text,
                                textController: viewModel.articleTitleCtrl,
                                onChanged: (v) {
                                  if (v.isNotEmpty) viewModel.articleTitleError();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    viewModel.articleTitleError.value,
                                    style: errorTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 40, 20, 4),
                              child: CustomTextField(
                                maxLength: 1500,
                                hintText: "Content ",
                                keyboardType: TextInputType.text,
                                textController: viewModel.contentCtrl,
                                onChanged: (v) {
                                  if (v.isNotEmpty) viewModel.contentTitleError;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    viewModel.contentTitleError.value,
                                    style: errorTextStyle,
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                              child:  CustomButton(
                                buttonColor: Colors.purple,
                                buttonTextColor: Colors.white,
                                isLoading: viewModel.isLoading.value,
                                buttonText: "Create post",
                                onPressed: () {
                                  viewModel.postFormValidator();
                                },
                              ),
                            ),
                            const Gap(12),
                          ]))))),
    );
  }
}
