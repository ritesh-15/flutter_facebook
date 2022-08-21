import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/controllers/users/profile_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/utils/snackbar_helper.dart';
import 'package:facebook/widgets/rounded_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CoverAndAvatar extends StatefulWidget {
  const CoverAndAvatar({
    Key? key,
    required ProfileController profileController,
  })  : _profileController = profileController,
        super(key: key);

  final ProfileController _profileController;

  @override
  State<CoverAndAvatar> createState() => _CoverAndAvatarState();
}

class _CoverAndAvatarState extends State<CoverAndAvatar> {
  final BaseController _baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Container(
                height: 250,
                width: double.maxFinite,
              ),
              if (widget._profileController.user?.cover != null &&
                  widget._profileController.user?.cover!.isNotEmpty)
                Container(
                    height: 200,
                    width: double.maxFinite,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Image.network(
                      widget._profileController.user?.cover!,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.maxFinite,
                    ))
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
                    child: GestureDetector(
                      onTap: () {
                        // choose cover image
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const ChooseImageBottomSheet(
                                isCoverImage: true,
                              );
                            });
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget._profileController.user?.id ==
                                  _baseController.user.id
                              ? [
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
                                ]
                              : []),
                    ),
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
                            child:
                                widget._profileController.user?.avatar != null
                                    ? Image.network(
                                        widget._profileController.user?.avatar!,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover)
                                    : CircleAvatar(
                                        radius: 70,
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                        child: const Icon(
                                          FontAwesomeIcons.solidUser,
                                          color: Colors.grey,
                                          size: 32,
                                        ),
                                      )),
                        if (_baseController.user.id ==
                            widget._profileController.user?.id)
                          Positioned(
                              right: 0,
                              left: 100,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  // choose avatar
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return const ChooseImageBottomSheet();
                                      });
                                },
                                child: const RoundedIconButton(
                                  icon: FontAwesomeIcons.camera,
                                ),
                              ))
                      ],
                    ),
                  )),
              if (_baseController.user.id == widget._profileController.user?.id)
                Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        // choose cover image
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const ChooseImageBottomSheet(
                                isCoverImage: true,
                              );
                            });
                      },
                      child: const RoundedIconButton(
                        icon: FontAwesomeIcons.camera,
                      ),
                    ))
            ],
          ),
        ));
  }
}

class ChooseImageBottomSheet extends StatefulWidget {
  final bool isCoverImage;

  const ChooseImageBottomSheet({Key? key, this.isCoverImage = false})
      : super(key: key);

  @override
  State<ChooseImageBottomSheet> createState() => _ChooseImageBottomSheetState();
}

class _ChooseImageBottomSheetState extends State<ChooseImageBottomSheet> {
  final _profileController = Get.find<ProfileController>();

  void chooseImage(ImageSource source) async {
    try {
      final imagePath = await ImagePicker().pickImage(source: source);

      if (imagePath == null) {
        SnackbarHelper.showSnackBar("Oops", "You have not choose any image!");
        return;
      }

      if (widget.isCoverImage) {
        _profileController.coverImageFilePath = imagePath.path;
        await _profileController.uploadAsCover();
      } else {
        _profileController.avatarImageFilePath = imagePath.path;
        await _profileController.uploadAsAvatar();
      }
    } catch (e) {
      SnackbarHelper.showSnackBar(
          "Oops", "You may not given permission for reading the storage!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(children: [
        GestureDetector(
          onTap: () {
            // choose the image from gallery
            chooseImage(ImageSource.gallery);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: const [
                Icon(CupertinoIcons.photo),
                SizedBox(
                  width: 12,
                ),
                Text("Choose from gallery")
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // choose image from camera
            chooseImage(ImageSource.camera);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: const [
                Icon(Icons.camera),
                SizedBox(
                  width: 12,
                ),
                Text("Take a photo")
              ],
            ),
          ),
        )
      ]),
    );
  }
}
