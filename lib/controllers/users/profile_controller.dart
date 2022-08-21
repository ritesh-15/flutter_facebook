import 'dart:io';

import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/model/follow_un_follow_response.dart';
import 'package:facebook/model/user/profile_response/ProfileUserData.dart';
import 'package:facebook/model/user/profile_response/profile_response.dart';
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

  // profile user
  final _user = Rxn<ProfileUserData?>().obs;
  ProfileUserData? get user => _user.value.value;
  set user(ProfileUserData? value) => _user.value.value = value;

  // loading state
  final RxBool _fetching = false.obs;
  bool get fetching => _fetching.value;
  set fetching(bool value) => _fetching.value = value;

  // loading state
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  void onInit() async {
    super.onInit();

    if (Get.arguments != null) {
      final String id = Get.arguments["id"];
      await fetchProfileData(id: id);
      return;
    }

    fetchProfileData();
  }

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

  Future<void> fetchProfileData({String? id}) async {
    fetching = true;
    final response = await UserService.getUserProfile(id);
    fetching = false;

    if (response is ProfileResponse) {
      user = response.user;
      return;
    }

    SnackbarHelper.showSnackBar("Oops!", response);
  }

  Future<void> follow() async {
    if (user == null) return;

    loading = true;

    final response = await UserService.follow(user!.id!);

    loading = false;

    if (response is FollowUnFollowResponse) {
      user?.isFollowedByMe = true;
      return;
    }

    SnackbarHelper.showSnackBar("Oops!", response);
  }

  Future<void> unFollow() async {
    if (user == null) return;

    loading = true;

    final response = await UserService.unFollow(user!.id!);

    loading = false;

    if (response is FollowUnFollowResponse) {
      user?.isFollowedByMe = false;
      return;
    }

    SnackbarHelper.showSnackBar("Oops!", response);
  }
}
