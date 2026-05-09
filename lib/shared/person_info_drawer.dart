import 'package:book_app/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PersonInfoDrawer extends StatefulWidget {
  PersonInfoDrawer({super.key});

  @override
  State<PersonInfoDrawer> createState() => _PersonInfoDrawerState();
}

class _PersonInfoDrawerState extends State<PersonInfoDrawer> {
  AppStore controller = Modular.get();
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
       decoration: const BoxDecoration(
         color: Colors.blue,
       ),         
       currentAccountPicture: Container(decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(50)),child: Center(child: Text(controller.currentUser?.name[0] ?? 'U', style: TextStyle(fontSize: 25),)),),
       accountName: Observer(builder: (_) {
          return Text(controller.currentUser?.name ?? 'user');
       },
       ),
       accountEmail: Observer(builder: (_) {
          return Text(controller.currentUser?.email ?? '-');
       },
       ),
     );
  }
}