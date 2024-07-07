import 'package:book_app/modules/auth/controller/auth_controller.dart';
import 'package:book_app/modules/auth/page/login_page.dart';
import 'package:book_app/modules/home/page/navigator_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthCheck extends StatelessWidget {
  AuthCheck({super.key});

  AuthController authController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
       return (authController.userIsAuthenticate) 
      ? const NavigatorBottom() 
      : const LoginPage();
    }
    );
  }
}