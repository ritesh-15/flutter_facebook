import 'package:facebook/constants/constants.dart';
import 'package:facebook/model/user/user_response.dart';
import 'package:facebook/model/user/user.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/services/token_service.dart';
import 'package:facebook/services/user/user_service.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  // user state
  final _user = Rxn<User?>().obs;
  User? get user => _user.value.value;
  set user(User? user) => _user.value.value = user;

  // is Logged In
  final Rx<bool> _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;
  set isLoggedIn(bool user) => _isLoggedIn.value = user;

  // loading state
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  void onInit() {
    super.onInit();
    _me();
  }

  void _me() async {
    final bool isFound =
        await TokenService.isTokenExits(Constants.refreshToken);

    if (!isFound) {
      await Get.offNamedUntil(NavigationRouter.loginRoute, (route) => false);
      return;
    }

    loading = true;

    final result = await UserService.me();

    if (result is UserResponse) {
      user = result.user!;
      isLoggedIn = true;
      return;
    }

    loading = false;
    await TokenService.clearTokens();
    await Get.offNamedUntil(NavigationRouter.loginRoute, (route) => false);
  }
}
