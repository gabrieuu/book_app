import 'package:book_app/core/status.dart';
import 'package:book_app/modules/search/controller/busca_controller.dart';
import 'package:book_app/modules/search/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListBooksSearch extends StatelessWidget {
  ListBooksSearch({super.key});

  BuscaController buscaController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Observer(builder: (_) {
      switch (buscaController.statusLivrosCarregando) {
        case Status.CARREGANDO:
          return const Center(child: CircularProgressIndicator());
        case Status.SUCESSO:
          return ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: buscaController.livrosEncontrados.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: BookTile(
                  book: buscaController.livrosEncontrados[index],
                ),
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
