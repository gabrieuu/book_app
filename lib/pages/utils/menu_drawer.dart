import 'package:book_app/data/service/auth_service/auth_service.dart';
import 'package:book_app/pages/favorites/favorites_page.dart';
import 'package:book_app/pages/utils/person_info_drawer.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
              children: [
                PersonInfoDrawer(),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return FavoritesPage();
                    },),);
                  },
                  title: Text("Favoritos"),
                  leading: Icon(Icons.favorite),
                )
              ],
            )),
            ListTile(
              onTap: (){
                AuthService.to.signOut();
              },
              title: Text("Sair do App"),
              leading: Icon(Icons.exit_to_app),
            )
          ],
        );
  }
}