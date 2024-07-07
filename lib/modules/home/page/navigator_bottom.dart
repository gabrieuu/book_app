import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/books/page/book_page.dart';
import 'package:book_app/modules/home/widgets/menu_drawer.dart';
import 'package:book_app/modules/favoritas/page/favorites_page.dart';
import 'package:book_app/modules/home/page/home_page.dart';
import 'package:book_app/modules/posts/page/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NavigatorBottom extends StatefulWidget {
  const NavigatorBottom({super.key});

  @override
  State<NavigatorBottom> createState() => _NavigatorBottomState();
}

class _NavigatorBottomState extends State<NavigatorBottom> {
  int index = 0;
  final userController = Modular.get<UserController>();


  @override
  void initState() {
    super.initState();
    userController.init();
    Modular.to.navigate('/initial${HomePage.route}');
  }

  _onTap(int index){
    switch (index) {
      case 0: 
        Modular.to.navigate('/initial${HomePage.route}');
        break;
      case 1: 
        Modular.to.navigate('/initial${BookPage.rota}');
        break;
      case 2:
        Modular.to.navigate('/initial${FavoritesPage.route}/');
        break;
      default:
        Modular.to.navigate('/initial${HomePage.route}');
    }
    this.index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Modular.to.pushNamed(PostPage.route);
      },child:  Icon(Icons.post_add, color: Colors.white),backgroundColor: Colors.blue, shape: CircleBorder()),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: _onTap,
        fixedColor: Colors.white,        
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio', backgroundColor: Colors.blue,),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Livros', backgroundColor: Colors.blue,),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos', backgroundColor: Colors.blue,),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outlined), label: 'Conversas', backgroundColor: Colors.blue,),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil', backgroundColor: Colors.blue,),
      ],
      ),
    );
  }
}