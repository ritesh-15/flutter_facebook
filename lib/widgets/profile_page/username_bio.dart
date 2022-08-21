import 'package:facebook/controllers/users/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserNameAndBio extends StatelessWidget {
  const UserNameAndBio({
    Key? key,
    required ProfileController profileController,
  })  : _profileController = profileController,
        super(key: key);

  final ProfileController _profileController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "${_profileController.user?.firstName} ${_profileController.user?.lastName}",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                _profileController.user?.bio ?? "",
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
