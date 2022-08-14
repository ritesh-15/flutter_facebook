import 'package:facebook/pages/authentication/acitvate_page.dart';
import 'package:facebook/pages/authentication/forgot_password_page.dart';
import 'package:facebook/pages/authentication/login_page.dart';
import 'package:facebook/pages/authentication/register_page.dart';
import 'package:facebook/pages/authentication/verify_otp_page.dart';
import 'package:facebook/pages/home_page.dart';
import 'package:facebook/pages/splash_page.dart';
import 'package:get/get.dart';

class NavigationRouter {
  // Authentication routes
  static const registerRoute = "/register";
  static const verifyOtpRoute = "/verifyOtp";
  static const loginRoute = "/login";
  static const activateRoute = "/activate";
  static const forgotPasswordRoute = "/forgot-password";

  // Home
  static const homeRoute = "/";

  // Splash
  static const splashRoute = "/splash";

  static const _transitionDuration = 250;

  static List<GetPage> routes = [
    // authentication routes
    GetPage(
        name: loginRoute,
        page: () => const LoginPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: _transitionDuration)),
    GetPage(
        name: registerRoute,
        page: () => const RegisterPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: _transitionDuration)),
    GetPage(
        name: verifyOtpRoute,
        page: () => const VerifyOtpPage(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: _transitionDuration)),
    GetPage(
        name: activateRoute,
        page: () => const ActivatePage(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: _transitionDuration)),
    GetPage(
        name: forgotPasswordRoute,
        page: () => const ForgotPasswordPage(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: _transitionDuration)),
    // home route
    GetPage(
        name: homeRoute,
        page: () => const HomePage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    // splash screen route
    GetPage(
        name: splashRoute,
        page: () => const SplashPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: _transitionDuration)),
  ];
}
