import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/route_names.dart';
import '../routes/route_pages.dart';
import 'app_binding.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: const AppBinding(),
      initialRoute: RouteNames.home,
      getPages: RoutePages.all,
    );
  }
}
