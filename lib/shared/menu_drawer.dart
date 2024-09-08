import 'package:book_app/modules/auth/controller/auth_controller.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/shared/person_info_drawer.dart';
import 'package:book_app/modules/favoritas/page/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({super.key});

  AuthController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            PersonInfoDrawer(),
          ],
        )),
        ListTile(
          onTap: () async {
            await controller.signOut();
          },
          title: Text("Sair do App"),
          leading: Icon(Icons.exit_to_app),
        )
      ],
    );
  }
}
