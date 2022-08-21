// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:facebook/theme/my_theme.dart';

class Skeleton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final BoxShape shape;

  const Skeleton({
    Key? key,
    required this.width,
    required this.height,
    this.radius = 12,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: MyTheme.lightGrey,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(radius)
              : null,
          shape: shape),
      duration: const Duration(seconds: 2),
    );
  }
}
