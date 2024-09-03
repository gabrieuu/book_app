import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/books/book_module.dart';
import 'package:book_app/modules/chat/chat_module.dart';
import 'package:book_app/modules/comment_post/comment_module.dart';
import 'package:book_app/modules/comment_post/controller/comment_controller.dart';
import 'package:book_app/modules/comment_post/repository/comment_repository.dart';
import 'package:book_app/modules/details/details_module.dart';
import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/home/page/home_page.dart';
import 'package:book_app/modules/home/page/navigator_bottom.dart';
import 'package:book_app/modules/posts/post_module.dart';
import 'package:book_app/modules/posts/post_repository/post_repository.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:book_app/modules/profiile/profile_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  // TODO: implement imports
  List<Module> get imports =>
      [AuthModule(), BookModule(), ProfileModule(), PostModule()];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => NavigatorBottom(), children: [
      ChildRoute('/home',
          child: (_) => HomePage(), transition: TransitionType.fadeIn),
      ModuleRoute('/book',
          module: BookModule(), transition: TransitionType.fadeIn),
      ModuleRoute('/profile',
          module: ProfileModule(), transition: TransitionType.fadeIn),
    ]);
    r.module('/chat', module: ChatModule());
    r.module('/post', module: PostModule());
    r.module('/comment', module: CommentModule());
  }
}
