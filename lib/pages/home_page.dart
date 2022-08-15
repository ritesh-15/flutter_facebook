import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/widgets/home_page/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: CustomScrollView(
        slivers: [
          TopAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                  [Center(child: Container(child: Text("Hello world")))]))
        ],
      ),
    );
  }
}
