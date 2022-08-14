import 'package:facebook/controllers/authentication/login/login_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:facebook/widgets/button.widget.dart';
import 'package:facebook/widgets/input.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // email address input
          InputWidget(
            textInputType: TextInputType.emailAddress,
            hintText: "Email address",
            obscureText: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email address is required!";
              }
              if (!value.isEmail) {
                return "Invalid email address format!";
              }

              return null;
            },
            onChanged: (value) {
              _loginController.email = value;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          // Password input
          Obx(
            () => InputWidget(
              textInputType: TextInputType.visiblePassword,
              hintText: "Password",
              obscureText: !_loginController.isPasswordVisible,
              suffixIcon: _loginController.isPasswordVisible
                  ? const Icon(CupertinoIcons.eye_slash)
                  : const Icon(CupertinoIcons.eye),
              onSuffixIconClick: () {
                _loginController.isPasswordVisible =
                    !_loginController.isPasswordVisible;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password  is required!";
                }

                if (value.length < 6) {
                  return "Invalid password, password length should be greater than 6 characters";
                }

                return null;
              },
              onChanged: (value) {
                _loginController.password = value;
              },
            ),
          ),

          const SizedBox(
            height: 22,
          ),
          // Login Button
          ButtonWidget(
            title: "Login",
            onTap: () async {
              if (_formKey.currentState!.validate() &&
                  !SnackbarHelper.isSnackBarOpen) {
                await _loginController.login();
              }
            },
            backgroundColor: MyTheme.primary,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}
