import 'package:facebook/controllers/authentication/forgot-password/forgot_password_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:facebook/widgets/button.widget.dart';
import 'package:facebook/widgets/input.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final ForgotPasswordController _forgotPasswordController =
      Get.put(ForgotPasswordController());

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
                const Text(
                  "Forgot your password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "We will sent you a forgot password link to your email address",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: InputWidget(
                    textInputType: TextInputType.emailAddress,
                    hintText: "Registered email address",
                    onChanged: (value) {
                      _forgotPasswordController.email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email address is required!";
                      }
                      if (!value.isEmail) {
                        return "Invalid email address format!";
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ButtonWidget(
                  title: "Send",
                  onTap: () async {
                    if (_formKey.currentState!.validate() &&
                        !SnackbarHelper.isSnackBarOpen) {
                      await _forgotPasswordController.forgotPassword();
                    }
                  },
                  backgroundColor: MyTheme.primary,
                  fullWidth: true,
                ),
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
