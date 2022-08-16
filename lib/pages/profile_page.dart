import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/widgets/button.widget.dart';
import 'package:facebook/widgets/home_page/create_post_container.dart';
import 'package:facebook/widgets/home_page/home_post_container.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:facebook/widgets/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          const _ProfileTopBar(),
          _CoverAndAvatar(baseController: _baseController),
          _UserNameAndBio(baseController: _baseController),
          const SizedBox(
            height: 12,
          ),
          _ProfileActions(),
          const SizedBox(
            height: 12,
          ),
          CreatePostContainer(),
        ]),
      ),
    );
  }
}

class _ProfileActions extends StatelessWidget {
  const _ProfileActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                color: MyTheme.primary, borderRadius: BorderRadius.circular(8)),
            child: Row(children: const [
              Icon(FontAwesomeIcons.circlePlus, color: Colors.white, size: 20),
              SizedBox(
                width: 12,
              ),
              Text(
                "Add To Story",
                style: TextStyle(color: Colors.white),
              )
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                color: MyTheme.lightGrey,
                borderRadius: BorderRadius.circular(8)),
            child: Row(children: const [
              Icon(
                FontAwesomeIcons.pen,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "Edit Profile",
              )
            ]),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  color: MyTheme.lightGrey,
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: 20,
              ))
        ],
      ),
    );
  }
}

class _UserNameAndBio extends StatelessWidget {
  const _UserNameAndBio({
    Key? key,
    required BaseController baseController,
  })  : _baseController = baseController,
        super(key: key);

  final BaseController _baseController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${_baseController.user.firstName} ${_baseController.user.lastName}",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(_baseController.user.bio ?? "")
      ],
    );
  }
}

class _CoverAndAvatar extends StatelessWidget {
  const _CoverAndAvatar({
    Key? key,
    required BaseController baseController,
  })  : _baseController = baseController,
        super(key: key);

  final BaseController _baseController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.maxFinite,
            ),
            if (_baseController.isLoggedIn &&
                _baseController.user.cover != null &&
                _baseController.user.cover!.isNotEmpty)
              Container(
                  height: 200,
                  width: double.maxFinite,
                  child: Image.network(_baseController.user.cover!))
            else
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: MyTheme.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.camera,
                          color: MyTheme.iconColor,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Add Cover Photo",
                          style: TextStyle(
                            fontSize: 16,
                            color: MyTheme.iconColor,
                          ),
                        )
                      ]),
                ),
              ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(_baseController.user.avatar!,
                            width: 150, height: 150, fit: BoxFit.cover),
                      ),
                      const Positioned(
                          right: 0,
                          left: 100,
                          bottom: 0,
                          child: RoundedIconButton(
                            icon: FontAwesomeIcons.camera,
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class _ProfileTopBar extends StatelessWidget {
  const _ProfileTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(FontAwesomeIcons.arrowLeft),
              padding: const EdgeInsets.all(0)),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // ignore: todo
                // TODO: Go to search page
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                    color: MyTheme.lightGrey,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: MyTheme.iconColor,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text("Search")
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
