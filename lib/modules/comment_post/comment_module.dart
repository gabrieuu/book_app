import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/comment_post/controller/comment_controller.dart';
import 'package:book_app/modules/comment_post/page/comment_page.dart';
import 'package:book_app/modules/comment_post/repository/comment_repository.dart';
import 'package:book_app/modules/posts/post_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CommentModule extends Module {
  @override
  // TODO: implement imports
  List<Module> get imports => [AuthModule(), PostModule()];

  @override
  void binds(Injector i) {
    i.add<CommentRepository>(CommentRepository.new);
    i.add(CommentController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => CommentPage(post: r.args.data));
  }
}
