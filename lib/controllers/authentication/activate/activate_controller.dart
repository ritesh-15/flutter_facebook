import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/model/user/activate_response/activate_response.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/services/user/user_service.dart';
import 'package:facebook/utils/dialog_helper.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class ActivateController extends GetxController {
  // first name
  final RxString _firstName = "".obs;
  String get firstName => _firstName.value;
  set firstName(value) => _firstName.value = value;

  // last name
  final RxString _lastName = "".obs;
  String get lastName => _lastName.value;
  set lastName(value) => _lastName.value = value;

  // password
  final RxString _password = "".obs;
  String get password => _password.value;
  set password(value) => _password.value = value;

  // password visibility toggle
  final RxBool _isPasswordVisible = false.obs;
  bool get isPasswordVisible => _isPasswordVisible.value;
  set isPasswordVisible(value) => _isPasswordVisible.value = value;

  // activate api error
  final RxString _errorMessage = "".obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(value) => _errorMessage.value = value;

  activate() async {
    DialogHelper.showLoading();
    final result = await UserService.activate(firstName, lastName, password);
    DialogHelper.hideLoading();

    if (result is ActivateResponse) return await _activateSuccess(result);

    errorMessage = result;

    if (errorMessage.isNotEmpty) {
      SnackbarHelper.showSnackBar("Oops", errorMessage);
    }
  }

  _activateSuccess(ActivateResponse result) async {
    // store the user
    final baseController = Get.find<BaseController>();
    baseController.user = result.user!;

    Get.offNamedUntil(NavigationRouter.homeRoute, (route) => false);
  }
}
