import 'package:book_app/model/images.dart';
import 'package:book_app/modules/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AuthController authController = Modular.get<AuthController>();

  @override
  void initState() {
    authController.isAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 249, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 300,
            child: Image.asset('assets/images/logo_book.png', fit: BoxFit.cover,),),
            const Text('Para leitores apaixonados por livros', style: TextStyle(fontSize: 14, color: Colors.blue),),
            SizedBox(height: 40,),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}