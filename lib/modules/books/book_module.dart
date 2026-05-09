import 'package:book_app/core/client_http/client_http.dart';
import 'package:book_app/core/client_http/dio_client.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';
import 'package:book_app/modules/books/repository/open_library_api_repository.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:book_app/modules/book_details/details_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<ClientHttp>(() => DioClient());
    i.addLazySingleton<BookRepository>(OpenLibraryApiRepository.new);
    i.addLazySingleton(BookStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/details', module: DetailsModule());
  }
}
