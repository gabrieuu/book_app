import 'package:book_app/data/service/auth_service/auth_service.dart';
import 'package:book_app/pages/home/home_page.dart';
import 'package:book_app/pages/loginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthService.to.userIsAuthenticate.value 
      ? HomePage() 
      : LoginPage());
  }
}