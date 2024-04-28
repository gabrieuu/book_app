import 'package:book_app/core/client_http/dio_client.dart';
import 'package:book_app/modules/home/page/home_page.dart';
import 'package:book_app/modules/home/repository/book_repository.dart';
import 'package:book_app/modules/home/store/book_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module{
  
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<BookRepository>(() => BookRepository(DioClient()));
    i.addLazySingleton(BookStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/home', child: (_) => const HomePage());
  }
}