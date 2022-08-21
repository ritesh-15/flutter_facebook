import 'package:facebook/controllers/users/profile_controller.dart';
import 'package:facebook/widgets/home_page/create_post_container.dart';
import 'package:facebook/widgets/profile_page/cover_avatar.dart';
import 'package:facebook/widgets/profile_page/profile_actions.dart';
import 'package:facebook/widgets/profile_page/profile_topbar.dart';
import 'package:facebook/widgets/profile_page/username_bio.dart';
import 'package:facebook/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => ListView(
              shrinkWrap: true,
              children: _profileController.fetching == true
                  ? [
                      const ProfileTopBar(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Stack(
                          children: [
                            Container(
                              height: 250,
                              width: double.maxFinite,
                            ),
                            const Skeleton(
                                width: double.maxFinite, height: 200),
                            const Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Skeleton(
                                  width: 150,
                                  height: 150,
                                  shape: BoxShape.circle,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Skeleton(
                                width: MediaQuery.of(context).size.width / 1,
                                height: 20),
                            const SizedBox(
                              height: 8,
                            ),
                            Skeleton(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 10),
                            const SizedBox(
                              height: 4,
                            ),
                            Skeleton(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 10)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Skeleton(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 50),
                            Skeleton(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 50),
                            Skeleton(
                                width: MediaQuery.of(context).size.width / 6,
                                height: 50)
                          ],
                        ),
                      )
                    ]
                  : [
                      const ProfileTopBar(),
                      CoverAndAvatar(profileController: _profileController),
                      UserNameAndBio(profileController: _profileController),
                      const SizedBox(
                        height: 12,
                      ),
                      const ProfileActions(),
                      const SizedBox(
                        height: 12,
                      ),
                      const CreatePostContainer(),
                    ],
            )),
      ),
    );
  }
}
