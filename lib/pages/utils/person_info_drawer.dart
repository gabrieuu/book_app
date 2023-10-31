import 'package:book_app/data/controller/user_controller.dart';
import 'package:book_app/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonInfoDrawer extends StatelessWidget {
  PersonInfoDrawer({super.key});
  
 UserService controller = UserService();
  
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),         
          currentAccountPicture: Container(decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(50)),child: Center(child: Text(UserController.to.user.name[0], style: TextStyle(fontSize: 25),)),),
          accountName: Text(UserController.to.user.name),
          accountEmail: Text(UserController.to.user.email),
        );
  }
}