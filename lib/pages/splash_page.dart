import 'package:facebook/constants/constants.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/services/token_service.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkForTokenInStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Center(
            child: Text(
          "facebook",
          style: TextStyle(
              color: MyTheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 38),
        )),
      ),
    );
  }

  void _checkForTokenInStorage() async {
    final bool isFound =
        await TokenService.isTokenExits(Constants.refreshToken);

    await Future.delayed(const Duration(seconds: 1));

    if (!isFound) {
      // redirect to login screen
      await Get.offNamedUntil(NavigationRouter.loginRoute, (route) => false);
      return;
    }

    await Get.offNamedUntil(NavigationRouter.homeRoute, (route) => false);
  }
}
