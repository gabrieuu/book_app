import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:book_app/modules/profiile/controller/profile_controller.dart';
import 'package:book_app/modules/profiile/pages/profile_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module{
  
  @override
  List<Module> get imports => [FavoritasModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(ProfileController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child:(_) => ProfilePage());
  }
}