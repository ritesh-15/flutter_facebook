import 'dart:io';

import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/model/user/user_response.dart';
import 'package:facebook/services/user/user_service.dart';
import 'package:facebook/utils/dialog_helper.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // avatar image state
  final RxString _avatarImageFilePath = "".obs;
  String get avatarImageFilePath => _avatarImageFilePath.value;
  set avatarImageFilePath(String value) => _avatarImageFilePath.value = value;

  // cover image state
  final RxString _coverImageFilePath = "".obs;
  String get coverImageFilePath => _coverImageFilePath.value;
  set coverImageFilePath(String value) => _coverImageFilePath.value = value;

  Future<void> uploadAsAvatar() async {
    print("$avatarImageFilePath 🚀🚀");

    // make api call to upload avatar
    DialogHelper.showLoading(title: "Uploading profile image please wait...");

    final response =
        await UserService.uploadAsAvatar(File(avatarImageFilePath));

    DialogHelper.hideLoading();

    if (response is UserResponse) {
      Get.find<BaseController>().user = response.user!;
      SnackbarHelper.showSnackBar(
          "Done", "Profile avatar updated successfully!",
          isError: false);
      return;
    }

    SnackbarHelper.showSnackBar("Oops", response);
  }

  Future<void> uploadAsCover() async {
    print("$coverImageFilePath 🚀🚀");

    // make api call to upload avatar
    DialogHelper.showLoading(title: "Uploading profile image please wait...");

    final response = await UserService.uploadAsCover(File(coverImageFilePath));

    DialogHelper.hideLoading();

    if (response is UserResponse) {
      Get.find<BaseController>().user = response.user!;
      SnackbarHelper.showSnackBar(
          "Done", "Profile avatar updated successfully!",
          isError: false);
      return;
    }

    SnackbarHelper.showSnackBar("Oops", response);
  }
}
