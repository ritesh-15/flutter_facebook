import 'package:facebook/constants/constants.dart';
import 'package:facebook/model/auth/refresh_response/refresh_response.dart';
import 'package:facebook/model/user/user.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/services/auth/auth_service.dart';
import 'package:facebook/services/token_service.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  // user state
  final Rx<User> _user = User().obs;
  User get user => _user.value;
  set user(User user) => _user.value = user;

  // loading state
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  void onInit() {
    super.onInit();
    _refresh();
  }

  void _refresh() async {
    final bool isFound =
        await TokenService.isTokenExits(Constants.refreshToken);

    if (!isFound) return;

    loading = true;

    final result = await AuthService.refresh();

    if (result is RefreshResponse) {
      loading = false;
      await TokenService.storeTokens(result.accessToken!, result.refreshToken!);
      user = result.user!;
      return;
    }

    await TokenService.clearTokens();

    loading = false;

    await Get.offNamedUntil(NavigationRouter.loginRoute, (route) => false);
  }
}
