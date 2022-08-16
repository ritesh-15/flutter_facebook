import 'package:facebook/widgets/home_page/create_post_container.dart';
import 'package:facebook/widgets/home_page/home_post_container.dart';
import 'package:facebook/widgets/home_page/story_container.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const SliverToBoxAdapter(child: CreatePostContainer()),
      const SliverToBoxAdapter(
        child: SizedBox(
          height: 8,
        ),
      ),
      const SliverToBoxAdapter(child: StoryContainer()),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return const HomePostContainer();
      }, childCount: 10))
    ]);
  }
}
