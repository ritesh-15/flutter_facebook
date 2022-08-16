import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/model/api_error_response.dart';
import 'package:facebook/model/auth/login_request.dart';
import 'package:facebook/model/auth/login_response/login_response.dart';
import 'package:facebook/model/auth/otp_response/otp_response.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/services/auth/auth_service.dart';
import 'package:facebook/services/token_service.dart';
import 'package:facebook/utils/dialog_helper.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // email
  final RxString _email = "".obs;
  String get email => _email.value;
  set email(value) => _email.value = value;

  // password
  final RxString _password = "".obs;
  String get password => _password.value;
  set password(value) => _password.value = value;

  // password visibility toggle
  final RxBool _isPasswordVisible = false.obs;
  bool get isPasswordVisible => _isPasswordVisible.value;
  set isPasswordVisible(value) => _isPasswordVisible.value = value;

  // login api error
  final RxString _errorMessage = "".obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(value) => _errorMessage.value = value;

  Future<void> login() async {
    DialogHelper.showLoading();

    final result =
        await AuthService.login(LoginRequest(email: email, password: password));

    if (result is LoginResponse) {
      DialogHelper.hideLoading();
      await _loginSuccess(result);
      return;
    }

    if (result is ApiErrorResponse) {
      errorMessage = result.message;

      if (result.code == 403) {
        await _handleLoginApiError(result, email);
        return;
      }

      DialogHelper.hideLoading();

      SnackbarHelper.showSnackBar("Oops", errorMessage);

      return;
    }

    errorMessage = result;

    DialogHelper.hideLoading();

    if (errorMessage.isNotEmpty) {
      SnackbarHelper.showSnackBar("Oops", errorMessage);
    }
  }

  Future<void> _loginSuccess(LoginResponse result) async {
    // store the tokens in storage
    await TokenService.storeTokens(result.accessToken!, result.refreshToken!);

    // store the user
    final baseController = Get.find<BaseController>();
    baseController.user = result.user!;
    baseController.isLoggedIn = true;

    Get.offNamedUntil(NavigationRouter.homeRoute, (route) => false);
  }

  Future<void> _handleLoginApiError(
      ApiErrorResponse result, String email) async {
    // send the otp to the user
    final otpResponse = await AuthService.resend(email);

    DialogHelper.hideLoading();

    if (otpResponse is OtpResponse) {
      // if otp send the redirect to verify page
      SnackbarHelper.showSnackBar("Yep!",
          "We found your account but it is not activated, we sent you verification code to your email please verify and activate you account!",
          isError: false);

      Get.toNamed(NavigationRouter.verifyOtpRoute, arguments: {
        "email": otpResponse.otp?.email,
        "hash": otpResponse.otp?.hash
      });

      return;
    }

    SnackbarHelper.showSnackBar("Oops", otpResponse);
  }
}
