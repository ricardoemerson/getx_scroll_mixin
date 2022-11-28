import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_scroll_mixin/pages/user_list/user_controller.dart';

class UserListPage extends StatelessWidget {
  final controller = Get.find<UserController>();

  UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserListPage'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.loadMorePages,
      ),
      body: controller.obx((state) {
        final totalItems = state?.length ?? 0;

        return ListView.builder(
          controller: controller.scroll,
          itemCount: totalItems + 1,
          itemBuilder: (context, index) {
            if (index == totalItems) {
              return Obx(() {
                return Visibility(
                  visible: controller.isLoading,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Carregando novos usuários...',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                );
              });
            }

            final user = state?[index];

            return ListTile(
              title: Text(user?.name ?? ''),
              subtitle: Text(user?.email ?? ''),
            );
          },
        );
      }),
    );
  }
}
