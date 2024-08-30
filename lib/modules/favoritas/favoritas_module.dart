import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/books/book_module.dart';
import 'package:book_app/modules/favoritas/page/favorites_page.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritasModule extends Module {
  @override
  // TODO: implement imports
  List<Module> get imports => [BookModule(), AuthModule()];

  @override
  void exportedBinds(Injector i) {
    i.addSingleton<FavoritaRepository>(FavoritaRepository.new);
    i.addSingleton<FavoritasStore>(FavoritasStore.new);
  }
}
