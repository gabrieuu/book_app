import 'package:book_app/modules/auth/controller/auth_controller.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/auth/page/login_page.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module{
  
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<AuthRepository>(() => AuthRepository());
    i.addSingleton<AuthController>(() => AuthController(i.get()));
    //i.addSingleton<UserController>(() => UserController());
  }

  @override
  void routes(RouteManager r) {
    r.child('/login', child:(_) => const LoginPage());
  }

}