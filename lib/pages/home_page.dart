import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/widgets/home_page/create_post_container.dart';
import 'package:facebook/widgets/home_page/home_post_container.dart';
import 'package:facebook/widgets/home_page/story_container.dart';
import 'package:facebook/widgets/home_page/top_app_bar.dart';
import 'package:facebook/widgets/tabs/home_tab.dart';
import 'package:facebook/widgets/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final _baseController = Get.find<BaseController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6);
    _tabController?.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.lightGrey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[TopAppBar(tabController: _tabController)];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            const HomeTab(),
            Center(child: Text("Not Implementd 🤒")),
            Center(child: Text("Not Implementd 🤒")),
            Center(child: Text("Not Implementd 🤒")),
            Center(child: Text("Not Implementd 🤒")),
            const ProfileTab()
          ],
        ),
      ),
    );
  }

  void _handleTabSelection() {
    setState(() {});
  }
}
