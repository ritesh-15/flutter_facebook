import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageURL;
  final double width;
  final double height;
  final bool hasBorder;

  const ProfileAvatar({
    Key? key,
    required this.imageURL,
    this.width = 55,
    this.height = 55,
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: MyTheme.primary,
      child: CircleAvatar(
        backgroundColor: MyTheme.lightGrey,
        radius: hasBorder ? 17 : 20,
        backgroundImage: CachedNetworkImageProvider(imageURL),
      ),
    );
  }
}
