import 'package:book_app/modules/books/page/book_page.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/home/page/home_page.dart';
import 'package:book_app/modules/posts/page/post_page.dart';
import 'package:book_app/modules/profiile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NavigatorBottom extends StatefulWidget {
  const NavigatorBottom({super.key});

  @override
  State<NavigatorBottom> createState() => _NavigatorBottomState();
}

class _NavigatorBottomState extends State<NavigatorBottom> {
  BottomNavigatorController controller = Modular.get();

  @override
  void initState() {
    super.initState();
    Modular.to.navigate('/initial${HomePage.route}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to.pushNamed(PostPage.route);
          },
          //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          child: Icon(Icons.post_add, color: Colors.white),
          backgroundColor: Colors.blue,
          shape: CircleBorder()),
      bottomNavigationBar: Observer(builder: (_) {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (value) => controller.currentIndex = value,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.blue[100],
          backgroundColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Livros',
              backgroundColor: Colors.blue,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.psychology_alt_outlined),
            //   label: 'Desafio',
            //   backgroundColor: Colors.blue,
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.chat_bubble_outlined),
            //   label: 'Conversas',
            //   backgroundColor: Colors.blue,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
              backgroundColor: Colors.blue,
            ),
          ],
        );
      }),
    );
  }
}
