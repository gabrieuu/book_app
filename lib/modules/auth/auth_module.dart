import 'package:book_app/modules/auth/controller/auth_controller.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/page/login_page.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:book_app/modules/auth/service/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<CustomAuthRepository>(AuthRepositorySupabase.new);
    i.addLazySingleton<CustomUserRepository>(UserRepositorySupabase.new);
    i.addLazySingleton<AuthService>(AuthService.new);
    i.addLazySingleton<AuthController>(AuthController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const LoginPage());
  }
}
