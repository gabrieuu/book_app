import 'dart:developer';

import 'package:book_app/core/status.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/search/widgets/person_tile.dart';
import 'package:book_app/modules/search/controller/busca_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListUsers extends StatefulWidget {
  ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  final BuscaController buscaController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Observer(builder: (_) {
      switch (buscaController.statusLeitoresCarregando) {
        case Status.CARREGANDO:
          return Center(child: CircularProgressIndicator());
        case Status.SUCESSO:
          return ListView.builder(
            itemCount: buscaController.leitoresEncrontrados.length,
            itemBuilder: (context, index) {
              return PersonTile(
                user: buscaController.leitoresEncrontrados[index],
              );
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
