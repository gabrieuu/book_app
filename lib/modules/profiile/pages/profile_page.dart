import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/profiile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  static String route = '/profile';
  
  ProfileController controller = Modular.get();
  BottomNavigatorController navigator = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue, size: 20,),
          onPressed: () => navigator.currentIndex = 0,
        ),
      ),
      body: Container(
        width: 200,
        child: Text(controller.userController.user.name),
      ),
    );
  }
}