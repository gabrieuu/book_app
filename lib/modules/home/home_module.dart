import 'package:book_app/modules/home/page/home_page.dart';
import 'package:book_app/modules/home/store/book_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module{
  
  @override
  void exportedBinds(Injector i) {
     i.addLazySingleton(() => BookStore());
  }

  @override
  void routes(RouteManager r) {
    r.child('/home', child: (_) => const HomePage());
  }
}