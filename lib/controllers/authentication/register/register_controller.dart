import 'package:facebook/model/auth/otp_response/otp_response.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/services/auth/auth_service.dart';
import 'package:facebook/utils/dialog_helper.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  // email
  final RxString _email = "".obs;
  String get email => _email.value;
  set email(value) => _email.value = value;

  // register api error
  final RxString _errorMessage = "".obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(value) => _errorMessage.value = value;

  register() async {
    DialogHelper.showLoading();
    final result = await AuthService.register(email);
    DialogHelper.hideLoading();

    if (result is OtpResponse) return await _registerSuccess(result);

    errorMessage = result;

    if (errorMessage.isNotEmpty) {
      SnackbarHelper.showSnackBar("Oops", errorMessage);
    }
  }

  _registerSuccess(OtpResponse result) async {
    SnackbarHelper.showSnackBar("Yeah!", result.message!, isError: false);

    Get.toNamed(NavigationRouter.verifyOtpRoute,
        arguments: {"email": result.otp?.email, "hash": result.otp?.hash});
  }
}
