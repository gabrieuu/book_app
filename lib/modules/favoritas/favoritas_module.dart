import 'package:book_app/modules/favoritas/page/favorites_page.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritasModule extends Module{

  @override
  void exportedBinds(Injector i) {    
    i.add<FavoritaRepository>(() => FavoritaRepository());
    i.addSingleton<FavoritasStore>(FavoritasStore.new);
  }
}