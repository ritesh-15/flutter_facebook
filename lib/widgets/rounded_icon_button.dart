// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoundedIconButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;

  const RoundedIconButton({
    Key? key,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor, shape: BoxShape.circle),
        child: Icon(
          icon,
          color: Theme.of(context).textTheme.headline1?.color,
          size: 20,
        ),
      ),
    );
  }
}
