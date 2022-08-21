import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/controllers/users/edit_profile_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:facebook/widgets/button.widget.dart';
import 'package:facebook/widgets/input.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _editProfileController = Get.put(EditProfileController());
  final _baseController = Get.find<BaseController>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _editProfileController.firstName = _baseController.user?.firstName!;
    _editProfileController.lastName = _baseController.user?.lastName!;
    _editProfileController.bio = _baseController.user?.bio ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Obx(() => InputWidget(
                                textInputType: TextInputType.text,
                                hintText: "First name",
                                initialValue: _editProfileController.firstName,
                                onChanged: (value) {
                                  _editProfileController.firstName = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Cannot be empty!";
                                  }

                                  return null;
                                },
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          Obx(() => InputWidget(
                                textInputType: TextInputType.text,
                                hintText: "Last name",
                                initialValue: _editProfileController.lastName,
                                onChanged: (value) {
                                  _editProfileController.lastName = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Cannot be empty!";
                                  }

                                  return null;
                                },
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          Obx(() => InputWidget(
                                textInputType: TextInputType.text,
                                hintText: "Bio",
                                initialValue: _editProfileController.bio,
                                maxLines: 4,
                                onChanged: (value) {
                                  _editProfileController.bio = value;
                                },
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          ButtonWidget(
                            title: "Save and Update",
                            onTap: () async {
                              if (_formKey.currentState!.validate() &&
                                  !SnackbarHelper.isSnackBarOpen) {
                                await _editProfileController.updateProfile();
                              }
                            },
                            backgroundColor: MyTheme.primary,
                            fullWidth: true,
                          )
                        ],
                      ))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
