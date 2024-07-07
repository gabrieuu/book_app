import 'package:book_app/modules/books/book_module.dart';
import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:book_app/modules/favoritas/page/favorites_page.dart';
import 'package:book_app/modules/home/page/home_page.dart';
import 'package:book_app/modules/home/page/navigator_bottom.dart';
import 'package:book_app/modules/comment_post/page/comment_page.dart';
import 'package:book_app/modules/posts/post_module.dart';
import 'package:book_app/modules/posts/post_repository/post_repository.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {

   @override
  void binds(Injector i) {
    i.addLazySingleton<PostRepository>(PostRepository.new);
    i.addLazySingleton<PostStore>(PostStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => HomePage());
  }
}