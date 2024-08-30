import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/comment_post/page/comment_page.dart';
import 'package:book_app/modules/posts/page/post_page.dart';
import 'package:book_app/modules/posts/post_repository/post_repository.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostModule extends Module {
  @override
  // TODO: implement imports
  List<Module> get imports => [AuthModule()];

  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<PostRepository>(PostRepository.new);
    i.addLazySingleton<PostStore>(PostStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => PostPage());
  }
}
