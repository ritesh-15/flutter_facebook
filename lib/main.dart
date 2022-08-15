import 'package:facebook/controllers/base_controller.dart';
import 'package:facebook/routes/navigation_routes.dart';
import 'package:facebook/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: unused_field
  final _baseController = Get.put(BaseController());

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Facebook',
      theme: MyTheme.lightTheme(),
      darkTheme: MyTheme.darkTheme(),
      debugShowCheckedModeBanner: false,
      getPages: NavigationRouter.routes,
      initialRoute: NavigationRouter.splashRoute,
      themeMode: ThemeMode.light,
    );
  }
}
