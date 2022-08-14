import 'package:facebook/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showLoading({String? title}) {
    Get.dialog(
        Dialog(
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: MyTheme.primary,
                  ),
                  if (title != null)
                    const SizedBox(
                      height: 16,
                    ),
                  if (title != null) Text(title)
                ]),
          ),
        ),
        barrierDismissible: false);
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
