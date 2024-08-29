import 'package:book_app/modules/auth/controller/auth_controller.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/auth/page/login_page.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:book_app/modules/primeiro_acesso/primeiro_acesso_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module{
  
  @override
  void exportedBinds(Injector i) {
    i.addInstance<AuthRepository>(AuthRepository());
    i.addInstance<UserRepository>(UserRepository());
    i.addLazySingleton<UserController>(UserController.new);
    i.addLazySingleton<AuthController>(AuthController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child:(_) => const LoginPage());
  }

}