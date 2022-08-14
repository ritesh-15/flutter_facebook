import 'package:facebook/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  static void showSnackBar(String title, String content,
      {bool isError = true}) {
    Get.showSnackbar(GetSnackBar(
      title: title,
      message: content,
      duration: const Duration(seconds: 3),
      icon: IconButton(
        onPressed: () {
          hideSnackBar();
        },
        icon: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      backgroundColor: isError ? MyTheme.error : MyTheme.success,
      animationDuration: const Duration(milliseconds: 500),
    ));
  }

  static void hideSnackBar() {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
  }

  static bool get isSnackBarOpen => Get.isSnackbarOpen;
}
