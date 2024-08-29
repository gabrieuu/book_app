import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/books/book_module.dart';
import 'package:book_app/modules/comment_post/comment_module.dart';
import 'package:book_app/modules/details/details_module.dart';
import 'package:book_app/modules/details/page/details_page.dart';
import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/home/home_module.dart';
import 'package:book_app/modules/home/page/navigator_bottom.dart';
import 'package:book_app/modules/posts/post_module.dart';
import 'package:book_app/modules/primeiro_acesso/primeiro_acesso_module.dart';
import 'package:book_app/modules/profiile/profile_module.dart';
import 'package:book_app/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module{

  @override
  List<Module> get imports => [
    AuthModule(),
  ];

  @override
  void binds(Injector i) {
    i.addLazySingleton<BottomNavigatorController>(BottomNavigatorController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => SplashScreen());
    r.module('/auth', module: AuthModule());
    r.module('/primeiro-acesso', module: PrimeiroAcessoModule());
    r.module('/initial', module: HomeModule());
   
  }
}