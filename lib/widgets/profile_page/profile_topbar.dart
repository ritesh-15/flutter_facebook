import 'package:facebook/theme/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({
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
