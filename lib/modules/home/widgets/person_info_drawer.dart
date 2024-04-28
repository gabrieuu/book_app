import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';

class PersonInfoDrawer extends StatelessWidget {
  PersonInfoDrawer({super.key});
  
 //UserController controller = UserController();
  
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
       decoration: BoxDecoration(
         color: Colors.blue,
       ),         
       currentAccountPicture: Container(decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(50)),child: Center(child: Text('controller.user.name[0]', style: TextStyle(fontSize: 25),)),),
       accountName: Observer(builder: (_) {
          return Text('controller.user.name');
       },
       ),
       accountEmail: Observer(builder: (_) {
          return Text('controller.user.email');
       },
       ),
     );
  }
}