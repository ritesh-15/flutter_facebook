import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/model/user/user_response.dart';
import 'package:facebook/services/user/user_service.dart';
import 'package:facebook/utils/dialog_helper.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  // first name
  final RxString _firstName = "".obs;
  String get firstName => _firstName.value;
  set firstName(value) => _firstName.value = value;

  // last name
  final RxString _lastName = "".obs;
  String get lastName => _lastName.value;
  set lastName(value) => _lastName.value = value;

  // bio
  final RxString _bio = "".obs;
  String get bio => _bio.value;
  set bio(value) => _bio.value = value;

  Future<void> updateProfile() async {
    DialogHelper.showLoading();

    final response = await UserService.updateProfile(firstName, lastName, bio);

    DialogHelper.hideLoading();

    if (response is UserResponse) {
      Get.find<BaseController>().user = response.user!;
      Get.back();
      SnackbarHelper.showSnackBar("Yep!", "Profile updated successfully!",
          isError: false);
      return;
    }

    SnackbarHelper.showSnackBar(
      "Oops!",
      response,
    );
  }
}
