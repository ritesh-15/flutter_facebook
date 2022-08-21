// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/controllers/users/profile_controller.dart';
import 'package:facebook/theme/my_theme.dart';

class ProfileActions extends StatefulWidget {
  const ProfileActions({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileActions> createState() => _ProfileActionsState();
}

class _ProfileActionsState extends State<ProfileActions> {
  final _baseController = Get.find<BaseController>();
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _profileController.user?.id == _baseController.user.id
              ? [
                  _ProfileActionButton(
                    backgroundColor: MyTheme.lightGrey,
                    icon: FontAwesomeIcons.plus,
                    title: "Add to story",
                  ),
                  _ProfileActionButton(
                    backgroundColor: MyTheme.primary,
                    icon: FontAwesomeIcons.pen,
                    title: "Edit Profile",
                    textColor: Colors.white,
                  ),
                  _ProfileActionButton(
                    backgroundColor: MyTheme.lightGrey,
                    icon: FontAwesomeIcons.ellipsis,
                  )
                ]
              : [
                  if (_profileController.user?.isFollowedByMe != null &&
                      _profileController.user!.isFollowedByMe == false)
                    _ProfileActionButton(
                        backgroundColor: MyTheme.primary,
                        title: "Follow",
                        icon: FontAwesomeIcons.userCheck,
                        loading: _profileController.loading,
                        textColor: Colors.white,
                        onTap: () async {
                          await _profileController.follow();
                        })
                  else
                    _ProfileActionButton(
                        backgroundColor: MyTheme.lightGrey,
                        title: "Unfollow",
                        icon: FontAwesomeIcons.userCheck,
                        loading: _profileController.loading,
                        onTap: () async {
                          await _profileController.unFollow();
                        }),
                  _ProfileActionButton(
                    backgroundColor: MyTheme.primary,
                    title: "Message",
                    textColor: Colors.white,
                    icon: FontAwesomeIcons.facebookMessenger,
                  ),
                  _ProfileActionButton(
                    backgroundColor: MyTheme.lightGrey,
                    icon: FontAwesomeIcons.ellipsis,
                  )
                ],
        )),
      ),
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  final String? title;
  final Color backgroundColor;
  final IconData? icon;
  final Color textColor;
  final Function()? onTap;
  final bool loading;

  const _ProfileActionButton({
    Key? key,
    this.title,
    required this.backgroundColor,
    this.icon,
    this.textColor = Colors.black,
    this.onTap,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(8)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: loading
                  ? [
                      SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: textColor,
                          strokeWidth: 2,
                        ),
                      ),
                      if (title != null)
                        const SizedBox(
                          width: 12,
                        ),
                      if (title != null)
                        Text(
                          title!,
                          style: TextStyle(fontSize: 16, color: textColor),
                        )
                    ]
                  : [
                      if (icon != null)
                        Icon(
                          icon,
                          color: textColor,
                          size: 20,
                        ),
                      if (icon != null && title != null)
                        const SizedBox(
                          width: 12,
                        ),
                      if (title != null)
                        Text(
                          title!,
                          style: TextStyle(fontSize: 16, color: textColor),
                        )
                    ]),
        ),
      ),
    );
  }
}
