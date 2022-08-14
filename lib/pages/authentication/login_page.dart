import 'package:facebook/pages/authentication/register_page.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:facebook/widgets/button.widget.dart';
import 'package:facebook/widgets/login_page/login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Center(
            child: ListView(shrinkWrap: true, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // facebook heading
                  Text(
                    "facebook",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: MyTheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  // Login Form
                  const LoginForm(),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(NavigationRouter.forgotPasswordRoute);
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: MyTheme.primary, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  // Create new account button
                  ButtonWidget(
                      title: "Create a new account",
                      onTap: () {
                        Get.toNamed(NavigationRouter.registerRoute);
                      },
                      backgroundColor: MyTheme.secondary),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
