import 'package:book_app/modules/search/widgets/person_tile.dart';
import 'package:book_app/modules/profiile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SeguidoresPage extends StatelessWidget {
  const SeguidoresPage({super.key, this.index = 0});

  final int index;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: index,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Seguidores'),
        ),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
                text: 'Seguidores',
              ),
              Tab(
                text: 'Seguindo',
              )
            ]),
            Expanded(
              child: TabBarView(children: [
                SeguidoresList(),
                SeguindoList(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class SeguidoresList extends StatelessWidget {
  SeguidoresList({super.key});

  final ProfileController perfilController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ListView.builder(
          itemCount: perfilController.listSeguidores.length,
          itemBuilder: (_, index) {
            return (perfilController.listSeguidores.isEmpty)
                ? const Center(
                    child: Text('Não possui nenhum Seguidor.'),
                  )
                : PersonTile(user: perfilController.listSeguidores[index]);
          });
    });
  }
}

class SeguindoList extends StatelessWidget {
  SeguindoList({super.key});

  final ProfileController perfilController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ListView.builder(
          itemCount: perfilController.listSeguindo.length,
          itemBuilder: (_, index) {
            return (perfilController.listSeguindo.isEmpty)
                ? const Center(
                    child: Text('Não segue ninguém.'),
                  )
                : PersonTile(user: perfilController.listSeguindo[index]);
          });
    });
  }
}
