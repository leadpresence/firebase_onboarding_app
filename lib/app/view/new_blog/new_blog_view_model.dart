import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart';
import 'dart:io';
import '../../common/di/depenndencies.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../models/blog_post.dart';

class NewBlogPostViewModel extends GetxController {
  final GlobalKey creatNewPostFormKey = GlobalKey();
  RxString errorName = "".obs;
  RxString articleTitleError = "".obs;
  RxString contentTitleError = "".obs;

  final utilsProvider = Get.find<UtilsProvider>();
  final TextEditingController authorNameCtrl = TextEditingController();
  final TextEditingController articleTitleCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();
  Rx<bool> isLoading = false.obs;
  Rx<bool> isRawImageAssigned = false.obs;
  Rx<bool> imageLoading = false.obs;
  Rx<String> imageName = ''.obs;
  Rx<File> imageFile = File('').obs;
  Rx<String> imageDownloadUrl = ''.obs;
  Rx<String> category = ''.obs;
  String profilePictureUrl = '';
  String profilePictureName = '';
  String base64Image = '';
  var extension;
  final _imagePicker = ImagePicker();
  PickedFile? pickedFile;

  void pickImage(BuildContext context) async {
    imageDownloadUrl.value = "";
    pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile!.path);
      GetStorage().write('rawImage', imageFile.value);
      isRawImageAssigned.value = true;
      List<int> imageBytes = imageFile.value.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      await uploadImage();
      refresh();
    }
  }

  uploadImage() async {
    imageLoading.value = true;
    if (pickedFile != null) {
      final fileName = basename(pickedFile!.path);

      //Upload to Firebase
      var snapshot = await utilsProvider.storageRef
          .ref()
          .child('images/$fileName')
          .putFile(imageFile.value);
      imageDownloadUrl.value = await snapshot.ref.getDownloadURL();
      imageLoading.value = false;
      BotToast.showText(text: "Image saved");


    } else {
      print('No Image Path Received');
    }
  }

  postFormValidator() {
    /// validates empty fields on the form
    if ((GetUtils.isBlank(authorNameCtrl.text)) == true) {
      return errorName.value = '      Name field cannot be blank.';
    } else if ((GetUtils.isBlank(articleTitleCtrl.text)) == true) {
      articleTitleError.value = '      Title field cannot be blank.';
    } else if ((GetUtils.isBlank(contentCtrl.text)) == true) {
      contentTitleError.value = '      Content field cannot be blank.';
    } else {
      createBlogPost();
    }
  }

  createBlogPost() {
    isLoading.value = true;
    utilsProvider.firebaseFirestore
        .collection(utilsProvider.blogCollectionPath)
        .add(BlogPost(
                author: authorNameCtrl.text.toString(),
                title: articleTitleCtrl.text.toString(),
                content: contentCtrl.text.toString(),
                imageLink: imageDownloadUrl.value.toString(),
                category: category.value.toString())
            .toMap())
        .then((value) {
      isLoading.value = false;
      BotToast.showText(text: "Post made successfully");
      if (kDebugMode) {
        print("Post Added");
      }
    }).catchError((error) {
      isLoading.value = false;
      if (kDebugMode) {
        print("Failed to add post: $error");
      }
    });
  }
}
