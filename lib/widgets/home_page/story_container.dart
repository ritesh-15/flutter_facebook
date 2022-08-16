import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoryContainer extends StatelessWidget {
  const StoryContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: ((context, index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.all(12),
                child: _StoryCard(
                  isAddToStory: true,
                ),
              );
            }

            return const Padding(
              padding: EdgeInsets.all(12),
              child: _StoryCard(),
            );
          })),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddToStory;

  const _StoryCard({
    Key? key,
    this.isAddToStory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            "https://images.unsplash.com/photo-1660578457871-355e94dbb82a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
            width: 110,
            fit: BoxFit.cover,
            height: double.maxFinite,
          ),
        ),
        Container(
          width: 110,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black26],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: isAddToStory
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: Icon(
                      FontAwesomeIcons.plus,
                      color: MyTheme.primary,
                    ),
                    onPressed: () {},
                  ),
                )
              : const ProfileAvatar(
                  imageURL:
                      "https://images.unsplash.com/photo-1553272725-086100aecf5e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxNnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                  width: 40,
                  height: 40,
                  hasBorder: true,
                ),
        ),
        Positioned(
            bottom: 8.0,
            left: 8,
            right: 8,
            child: isAddToStory
                ? const Text(
                    "Add to story",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                : const Text("Ritesh Khore",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)))
      ],
    );
  }
}
