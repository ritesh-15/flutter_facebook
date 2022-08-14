import 'package:facebook/controllers/authentication/register/register_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:facebook/widgets/button.widget.dart';
import 'package:facebook/widgets/input.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final RegisterController _registerController = Get.put(RegisterController());

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
                  "Start your journey with us.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Connect with people around the glob with just one click",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: InputWidget(
                    textInputType: TextInputType.emailAddress,
                    hintText: "Email address",
                    onChanged: (value) {
                      _registerController.email = value;
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
                  title: "Continue",
                  onTap: () async {
                    if (_formKey.currentState!.validate() &&
                        !SnackbarHelper.isSnackBarOpen) {
                      await _registerController.register();
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
