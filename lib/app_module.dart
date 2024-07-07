import 'package:book_app/auth_check.dart';
import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/books/book_module.dart';
import 'package:book_app/modules/books/page/book_page.dart';
import 'package:book_app/modules/comment_post/comment_module.dart';
import 'package:book_app/modules/details/details_module.dart';
import 'package:book_app/modules/details/page/details_page.dart';
import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:book_app/modules/favoritas/page/favorites_page.dart';
import 'package:book_app/modules/home/home_module.dart';
import 'package:book_app/modules/home/page/navigator_bottom.dart';
import 'package:book_app/modules/posts/post_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module{

  @override
  List<Module> get imports => [
    AuthModule(),
    DetailsModule(),
  ];

  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
    r.child('/initial', child: (_) => NavigatorBottom(), children: [
      ModuleRoute('/home', module: HomeModule(), transition: TransitionType.leftToRight),
      ModuleRoute('/book', module: BookModule(), transition: TransitionType.rightToLeft),
      ModuleRoute('/favoritas', module: FavoritasModule(), transition: TransitionType.rightToLeft),
    ]);
    r.module('/post', module: PostModule());
    r.module('/comment', module: CommentModule());
    r.child('/details', child: (_) => DetailsPage(book: r.args.data,));
   
  }
}