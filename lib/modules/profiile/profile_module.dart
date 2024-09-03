import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/books/book_module.dart';
import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:book_app/modules/posts/post_module.dart';
import 'package:book_app/modules/profiile/controller/profile_controller.dart';
import 'package:book_app/modules/profiile/pages/profile_page.dart';
import 'package:book_app/modules/profiile/pages/seguidores_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  List<Module> get imports =>
      [FavoritasModule(), AuthModule(), PostModule(), BookModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(ProfileController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => ProfilePage(
              userId: r.args.data,
            ));
    r.child('/seguidores',
        child: (_) => SeguidoresPage(
              index: r.args.data ?? 0,
            ));
  }
}
