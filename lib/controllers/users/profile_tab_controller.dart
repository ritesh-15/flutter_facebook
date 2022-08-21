import 'package:facebook/model/logout_response.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/services/auth/auth_service.dart';
import 'package:facebook/services/token_service.dart';
import 'package:facebook/utils/dialog_helper.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:get/get.dart';

class ProfileTabController extends GetxController {
  Future<void> logout() async {
    DialogHelper.showLoading();
    final response = await AuthService.logout();
    DialogHelper.hideLoading();

    if (response is LogoutResponse) {
      await TokenService.clearTokens();
      Get.offNamedUntil(NavigationRouter.loginRoute, (route) => false);
      SnackbarHelper.showSnackBar("Good by!", "Log out successfully!",
          isError: false);
      return;
    }

    SnackbarHelper.showSnackBar("Oops", response);
  }
}
