import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/books/book_module.dart';
import 'package:book_app/modules/search/controller/busca_controller.dart';
import 'package:book_app/modules/search/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchModule extends Module {
  @override
  List<Module> get imports => [AuthModule(), BookModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<BuscaController>(BuscaController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => SearchPage());
  }
}
