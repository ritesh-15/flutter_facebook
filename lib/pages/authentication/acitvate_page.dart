import 'package:facebook/controllers/authentication/activate/activate_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:facebook/widgets/button.widget.dart';
import 'package:facebook/widgets/input.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivatePage extends StatefulWidget {
  const ActivatePage({Key? key}) : super(key: key);

  @override
  State<ActivatePage> createState() => _ActivatePageState();
}

class _ActivatePageState extends State<ActivatePage> {
  final _formKey = GlobalKey<FormState>();

  final ActivateController _activateController = Get.put(ActivateController());

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
                  "One step to go!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Setup basic details and password to start using app",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputWidget(
                          textInputType: TextInputType.emailAddress,
                          hintText: "First name",
                          onChanged: (value) {
                            _activateController.firstName = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required!";
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InputWidget(
                          textInputType: TextInputType.emailAddress,
                          hintText: "Last name",
                          onChanged: (value) {
                            _activateController.lastName = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required!";
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => InputWidget(
                            textInputType: TextInputType.visiblePassword,
                            hintText: "Password",
                            obscureText: !_activateController.isPasswordVisible,
                            suffixIcon: _activateController.isPasswordVisible
                                ? const Icon(CupertinoIcons.eye_slash)
                                : const Icon(CupertinoIcons.eye),
                            onSuffixIconClick: () {
                              _activateController.isPasswordVisible =
                                  !_activateController.isPasswordVisible;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required!";
                              }

                              if (value.length < 6) {
                                return "Invalid password, password length should be greater than 6 characters";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              _activateController.password = value;
                            },
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 28,
                ),
                ButtonWidget(
                  title: "Save and Continue",
                  onTap: () {
                    if (_formKey.currentState!.validate() &&
                        !SnackbarHelper.isSnackBarOpen) {
                      _activateController.activate();
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
