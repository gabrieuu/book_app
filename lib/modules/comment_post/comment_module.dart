import 'package:book_app/modules/comment_post/controller/comment_controller.dart';
import 'package:book_app/modules/comment_post/page/comment_page.dart';
import 'package:book_app/modules/comment_post/repository/comment_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CommentModule extends Module{

  @override
  void binds(Injector i) {
    i.addInstance<CommentRepository>(CommentRepository());
    i.addInstance<CommentController>(CommentController(repository: i.get()));
  }


  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => CommentPage(post: r.args.data));
  }
}