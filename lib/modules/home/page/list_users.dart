import 'package:book_app/core/status.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/home/widgets/person_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListUsers extends StatelessWidget {
  ListUsers({super.key});

  final UserController userController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
          switch(userController.usersSearcheds){
            case Status.CARREGANDO:
              return Center(child: CircularProgressIndicator());
            case Status.SUCESSO:
              return ListView.builder(
                itemCount: userController.usersSearched.length,
                itemBuilder: (context, index) {
                  return PersonTile(user: userController.usersSearched[index],);
                },
              );
            case Status.ERRO:
              return Center(child: Text('Erro ao carregar os usuários'));
            default:
             return SizedBox();
          }
      
    }));
  }
}
