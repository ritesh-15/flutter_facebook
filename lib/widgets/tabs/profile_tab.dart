// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebook/controllers/users/profile_tab_controller.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:facebook/widgets/button.widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:facebook/widgets/rounded_icon_button.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: CustomScrollView(slivers: [
        const _ProfileTabHeader(),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        if (_baseController.isLoggedIn)
          _ProfileTabUserDetails(baseController: _baseController),
        const SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),
        const SliverToBoxAdapter(child: Divider()),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        const _AllShortcuts()
      ]),
    );
  }
}

class _AllShortcuts extends StatefulWidget {
  const _AllShortcuts({Key? key}) : super(key: key);

  @override
  State<_AllShortcuts> createState() => _AllShortcutsState();
}

class _AllShortcutsState extends State<_AllShortcuts> {
  final _profileTabController = Get.put(ProfileTabController());

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          ButtonWidget(
            title: "Log Out",
            onTap: () async {
              if (!SnackbarHelper.isSnackBarOpen) {
                await _profileTabController.logout();
              }
            },
            backgroundColor: MyTheme.iconColor,
            fullWidth: true,
          )
        ],
      ),
    );
  }
}

class _ShortCutItem extends StatelessWidget {
  final String image;
  final String label;

  const _ShortCutItem({
    Key? key,
    required this.image,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ProfileTabUserDetails extends StatelessWidget {
  const _ProfileTabUserDetails({
    Key? key,
    required BaseController baseController,
  })  : _baseController = baseController,
        super(key: key);

  final BaseController _baseController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () {
          Get.toNamed(NavigationRouter.profileRoute);
        },
        child: Row(
          children: [
            if (_baseController.user?.avatar != null)
              ProfileAvatar(imageURL: _baseController.user!.avatar!)
            else
              CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).cardColor,
                child: const Icon(
                  FontAwesomeIcons.solidUser,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${_baseController.user?.firstName} ${_baseController.user?.lastName}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                const Text("See your profile")
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ProfileTabHeader extends StatelessWidget {
  const _ProfileTabHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          "Menu",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        Row(
          children: const [
            RoundedIconButton(icon: Icons.settings),
            RoundedIconButton(icon: FontAwesomeIcons.magnifyingGlass)
          ],
        )
      ]),
    );
  }
}
