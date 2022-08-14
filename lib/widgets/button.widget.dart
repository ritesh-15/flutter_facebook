// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:facebook/theme/my_theme.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color backgroundColor;
  final Int? borderRadius;
  final bool fullWidth;

  const ButtonWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.backgroundColor,
      this.borderRadius,
      this.fullWidth = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.maxFinite : null,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(blurRadius: 5, spreadRadius: 5, color: MyTheme.lightGrey)
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
