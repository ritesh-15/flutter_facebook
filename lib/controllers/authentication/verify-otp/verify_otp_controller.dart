import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/model/auth/otp_response/otp_response.dart';
import 'package:facebook/model/auth/verify_response/verify_response.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/services/auth/auth_service.dart';
import 'package:facebook/services/token_service.dart';
import 'package:facebook/utils/dialog_helper.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  // email
  final RxString _email = "".obs;
  String get email => _email.value;
  set email(value) => _email.value = value;

  // hash
  final RxString _hash = "".obs;
  String get hash => _hash.value;
  set hash(value) => _hash.value = value;

  // code
  final RxString _code = "".obs;
  String get code => _code.value;
  set code(value) => _code.value = value;

  // timer
  final RxInt _timer = 0.obs;
  int get timer => _timer.value;
  set timer(value) => _timer.value = value;

  // register api error
  final RxString _errorMessage = "".obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(value) => _errorMessage.value = value;

  // resend otp count
  final RxInt _resendCount = 0.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      email = Get.arguments["email"];
      hash = Get.arguments["hash"];
    }
  }

  Future<void> verify() async {
    if (code.isEmpty || code.length < 4) {
      SnackbarHelper.showSnackBar("Oops", "Invalid verification code!");
      return;
    }

    if (code.length > 4) {
      code = code.substring(code.length - 4);
    }

    DialogHelper.showLoading();
    final result = await AuthService.verify(email, hash, code);
    DialogHelper.hideLoading();

    if (result is VerifyOtpResponse) return await _verifyOtpSuccess(result);

    errorMessage = result;

    if (errorMessage.isNotEmpty) {
      SnackbarHelper.showSnackBar("Oops", errorMessage);
    }
  }

  Future<void> resendCode() async {
    if (_resendCount.value >= 3) {
      SnackbarHelper.showSnackBar(
          "Oops", "You have reached the maximum number of resend attempts!");
      return;
    }

    if (email.isEmpty) {
      SnackbarHelper.showSnackBar("Oops", "Something went wrong!");
      Get.offNamedUntil(NavigationRouter.registerRoute, (route) => false);
      return;
    }

    DialogHelper.showLoading();
    final result = await AuthService.resend(email);
    DialogHelper.hideLoading();

    if (result is OtpResponse) return _resendOtpSuccess(result);

    errorMessage = result;

    if (errorMessage.isNotEmpty) {
      SnackbarHelper.showSnackBar("Oops", errorMessage);
    }
  }

  Future<void> _verifyOtpSuccess(VerifyOtpResponse result) async {
    // store the tokens in storage
    await TokenService.storeTokens(result.accessToken!, result.refreshToken!);

    // store the user
    final baseController = Get.find<BaseController>();
    baseController.user = result.user!;

    SnackbarHelper.showSnackBar(
        "Yep", "Your email address is successfully verified!",
        isError: false);

    if (result.user!.isActivated!) {
      return Get.offNamedUntil(NavigationRouter.homeRoute, (route) => false);
    }

    Get.offNamedUntil(NavigationRouter.activateRoute, (route) => false);
  }

  void _resendOtpSuccess(OtpResponse result) {
    // update the hash and email in controller
    hash = result.otp?.hash;
    email = result.otp?.email;

    SnackbarHelper.showSnackBar(
        "Yep", "Verification code sent successfully to you email address!",
        isError: false);

    _resendCount.value += 1;
  }
}
