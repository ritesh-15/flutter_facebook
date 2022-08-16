import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:facebook/theme/my_theme.dart';

class HomePostContainer extends StatefulWidget {
  const HomePostContainer({Key? key}) : super(key: key);

  @override
  State<HomePostContainer> createState() => _HomePostContainerState();
}

class _HomePostContainerState extends State<HomePostContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: const [
                _PostHeader(),
                SizedBox(
                  height: 12,
                ),
                _PostContent()
              ]),
            ),
            const _PostImage(),
            const _PostStats(),
            const Divider(),
            const _PostActions()
          ],
        ),
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  const _PostActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _PostActionButton(
            label: "Like",
            icon: FontAwesomeIcons.thumbsUp,
            onPressed: () {},
          ),
          _PostActionButton(
            label: "Comments",
            icon: FontAwesomeIcons.comment,
            onPressed: () {},
          ),
          _PostActionButton(
            label: "Share",
            icon: FontAwesomeIcons.share,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class _PostStats extends StatelessWidget {
  const _PostStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("5.9K"),
          Row(
            children: const [
              Text("891 comments."),
              SizedBox(width: 8),
              Text("7 Share")
            ],
          )
        ],
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://images.unsplash.com/photo-1660578457871-355e94dbb82a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
      height: 300,
      fit: BoxFit.cover,
      loadingBuilder: (context, widget, l) {
        return Container(
          height: 300,
          color: MyTheme.lightGrey,
          child: widget,
        );
      },
    );
  }
}

class _PostContent extends StatelessWidget {
  const _PostContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
      style: TextStyle(height: 1.8),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ProfileAvatar(
            imageURL:
                "https://images.unsplash.com/photo-1660489060328-9868cad59617?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyM3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Chennai Super Kings",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "18h",
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.subtitle1?.color),
              )
            ],
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.ellipsis,
              color: MyTheme.iconColor,
              size: 14,
            ))
      ],
    );
  }
}

class _PostActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onPressed;

  const _PostActionButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(MyTheme.lightGrey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: MyTheme.iconColor,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: TextStyle(
              color: MyTheme.iconColor,
            ),
          )
        ],
      ),
    );
  }
}
