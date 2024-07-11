import 'package:book_app/core/client_http/client_http.dart';
import 'package:book_app/core/client_http/dio_client.dart';
import 'package:book_app/modules/books/page/book_page.dart';
import 'package:book_app/modules/books/repository/book_repository.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookModule extends Module{
  
  @override
  void binds(Injector i) {
    i.addLazySingleton<ClientHttp>(() => DioClient());
    i.addSingleton<BookRepository>(() => BookRepository(i.get()));
    i.addLazySingleton(() => BookStore(i.get()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const BookPage());
  }
}