import 'package:book_app/modules/search/controller/busca_controller.dart';
import 'package:book_app/modules/search/widgets/list_books_search.dart';
import 'package:book_app/modules/search/widgets/list_users_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:hive/hive.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  Debouncer debouncer = Debouncer(delay: Duration(milliseconds: 500));
  final BuscaController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller.searchTextFieldController,
                onChanged: (value) {
                  if (controller.searchTextFieldController.text.isEmpty) {
                    controller.leitoresEncrontrados.clear();
                    controller.livrosEncontrados.clear();
                    return;
                  }
                  if (value.isNotEmpty) {
                    debouncer(() async {
                      print('atualizou');
                      await controller.buscar(value: value);
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  hintStyle: TextStyle(),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              TabBar(
                  onTap: (value) {
                    controller.buscarPorTabBar(value);
                  },
                  tabs: [
                    Tab(text: 'Livros'),
                    Tab(text: 'Leitores'),
                  ]),
              Expanded(
                child: TabBarView(children: [
                  ListBooksSearch(),
                  ListUsers(),
                ]),
              )
            ],
          )),
    );
  }
}
