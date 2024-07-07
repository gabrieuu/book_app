import 'package:book_app/modules/favoritas/page/favorites_page.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritasModule extends Module{

  @override
  void binds(Injector i) {    
    i.addSingleton<FavoritaRepository>(() => FavoritaRepository());
    i.addLazySingleton<FavoritasStore>(FavoritasStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const FavoritesPage());
  }
}