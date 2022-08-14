import 'package:facebook/model/auth/forgot-password/forgot_password_response.dart';
import 'package:facebook/services/auth/auth_service.dart';
import 'package:facebook/utils/dialog_helper.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // email
  final RxString _email = "".obs;
  String get email => _email.value;
  set email(value) => _email.value = value;

  // register api error
  final RxString _errorMessage = "".obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(value) => _errorMessage.value = value;

  Future<void> forgotPassword() async {
    DialogHelper.showLoading();
    final result = await AuthService.forgotPassword(email);
    DialogHelper.hideLoading();

    if (result is ForgotPasswordResponse) return _forgotPasswordSuccess();

    errorMessage = result;

    if (errorMessage.isNotEmpty) {
      SnackbarHelper.showSnackBar("Oops", errorMessage);
    }
  }

  void _forgotPasswordSuccess() {
    SnackbarHelper.showSnackBar(
        "Yep", "Password reset link is sent to you email address!",
        isError: false);
  }
}
