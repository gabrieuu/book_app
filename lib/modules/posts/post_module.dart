import 'package:book_app/modules/comment_post/page/comment_page.dart';
import 'package:book_app/modules/posts/page/post_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostModule extends Module{

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => PostPage());
  }
}