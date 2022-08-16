import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CreatePostContainer extends StatefulWidget {
  const CreatePostContainer({Key? key}) : super(key: key);

  @override
  State<CreatePostContainer> createState() => _CreatePostContainerState();
}

class _CreatePostContainerState extends State<CreatePostContainer> {
  final _baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(children: [
        Obx(() {
          if (_baseController.isLoggedIn &&
              _baseController.user.avatar != null) {
            return ProfileAvatar(imageURL: _baseController.user.avatar!);
          }

          return CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).cardColor,
            child: const Icon(
              FontAwesomeIcons.solidUser,
              color: Colors.grey,
            ),
          );
        }),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Theme.of(context).cardColor),
                borderRadius: BorderRadius.circular(22)),
            child: const Text(
              "Write something here...",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.image,
              color: MyTheme.secondary,
            ))
      ]),
    );
  }
}
