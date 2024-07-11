import 'package:book_app/modules/comment_post/controller/comment_controller.dart';
import 'package:book_app/modules/comment_post/repository/comment_repository.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/home/page/home_page.dart';
import 'package:book_app/modules/posts/post_repository/post_repository.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {


   @override
  void binds(Injector i) {
    i.addLazySingleton<PostRepository>(PostRepository.new);
    i.addLazySingleton<PostStore>(PostStore.new);
    i.addInstance<CommentRepository>(CommentRepository());
    i.addInstance<CommentController>(CommentController(repository: i.get()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => HomePage());
  }
}