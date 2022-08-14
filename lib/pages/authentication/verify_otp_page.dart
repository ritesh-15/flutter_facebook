import 'package:facebook/controllers/authentication/verify-otp/verify_otp_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:facebook/widgets/button.widget.dart';
import 'package:facebook/widgets/code.input.widget.dart';
import 'package:facebook/widgets/input.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({Key? key}) : super(key: key);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final _formKey = GlobalKey<FormState>();

  final _verifyOtpController = Get.put(VerifyOtpController());

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
                  "Verification code sent!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 4,
                ),
                Obx(() => Text(
                      "We have sent you a verification code to your email address ${_verifyOtpController.email} valid only for 10 minutes.",
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  height: 28,
                ),
                Form(
                  key: _formKey,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CodeInputWidget(
                          onChanged: (value) {
                            if (value != null) {
                              _verifyOtpController.code += value;
                            }
                          },
                        ),
                        CodeInputWidget(
                          onChanged: (value) {
                            if (value != null) {
                              _verifyOtpController.code += value;
                            }
                          },
                        ),
                        CodeInputWidget(
                          onChanged: (value) {
                            if (value != null) {
                              _verifyOtpController.code += value;
                            }
                          },
                        ),
                        CodeInputWidget(
                          onChanged: (value) {
                            if (value != null) {
                              _verifyOtpController.code += value;
                            }
                          },
                        )
                      ]),
                ),
                const SizedBox(
                  height: 28,
                ),
                ButtonWidget(
                  title: "Verify",
                  onTap: () async {
                    if (_formKey.currentState!.validate() &&
                        !SnackbarHelper.isSnackBarOpen) {
                      await _verifyOtpController.verify();
                    }
                  },
                  backgroundColor: MyTheme.primary,
                  fullWidth: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Didn't receive verification code?",
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    await _verifyOtpController.resendCode();
                  },
                  child: Text(
                    "Resend code",
                    style: TextStyle(
                        fontSize: 14,
                        color: MyTheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
