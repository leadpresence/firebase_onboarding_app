import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart';
import 'dart:io';
import '../../common/di/depenndencies.dart';

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
  Rx<File> imageFile = File('').obs;
  Rx<String> imageLoading = "".obs;
  Rx<String> imageName = ''.obs;
  Rx<String> imageDownloadUrl = ''.obs;
  String profilePictureUrl = '';
  String profilePictureName = '';
  String base64Image = '';
  var extension;
  final _imagePicker = ImagePicker();
  PickedFile? pickedFile;

  void pickImage(BuildContext context) async {

       pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
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

  // Future<String> uploadFile(BuildContext context) async {
  //   final file = basename(imageFile.value.path);
  //   extension = p.extension(imageFile.value.path);
  //   String filePath = imageFile.value.path;
  //   final _imagePicker = ImagePicker();
  //   PickedFile image;
  //   //Check Permissions
  //
  //   try {
  //     await mountainsRef.putFile(file);
  //   } on FirebaseException catch (e) {
  //     // ...
  //   }
  //   final urlDownload = await mountainsRef.getDownloadURL();
  //   profilePictureName = file;
  //   profilePictureUrl = urlDownload.split("?")[0];
  //   return urlDownload;
  // }

  uploadImage() async {
      if (pickedFile != null) {
        //Upload to Firebase
        var snapshot = await utilsProvider.storageRef
            .child('images/imageName')
            .putFile(imageFile.value).whenComplete(() => null);
        imageDownloadUrl.value = await  snapshot.ref.getDownloadURL();
        // showTopSnackBar(
        //   context,
        //   CustomSnackBar.info(
        //     message:
        //     "Download from :${imageDownloadUrl.value.toString()}",
        //   ),
        // );
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

  createBlogPost(){

  }
}
