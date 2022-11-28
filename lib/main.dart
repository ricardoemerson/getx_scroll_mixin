import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_scroll_mixin/pages/user_list/user_controller.dart';
import 'package:getx_scroll_mixin/pages/user_list/user_list_page.dart';

import 'repositories/user/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Scroll Mixin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(
          () => Dio(BaseOptions(baseUrl: 'http://192.168.1.107:3000')),
          fenix: true,
        );

        Get.lazyPut(
          () => UserRepository(dio: Get.find()),
          fenix: true,
        );
      }),
      getPages: [
        GetPage(
          name: '/',
          binding: BindingsBuilder.put(() => UserController(
                userRepository: Get.find(),
              )),
          page: () => UserListPage(),
        ),
      ],
    );
  }
}
