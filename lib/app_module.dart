import 'package:book_app/auth_check.dart';
import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/details/details_module.dart';
import 'package:book_app/modules/details/page/details_page.dart';
import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:book_app/modules/favoritas/page/favorites_page.dart';
import 'package:book_app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module{

  @override
  List<Module> get imports => [
    AuthModule(),
    HomeModule(),
    FavoritasModule(),
    DetailsModule()
  ];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => AuthCheck());
    r.child('/favoritas', child: (_) => FavoritesPage());
    r.child('/details', child: (_) => DetailsPage(book: r.args.data,));
  }
}