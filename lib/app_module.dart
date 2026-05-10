import 'package:book_app/app_store.dart';
import 'package:book_app/core/core_module.dart';
import 'package:book_app/infra/client_http/client_http.dart';
import 'package:book_app/infra/client_http/dio_client.dart';
import 'package:book_app/modules/auth/auth_module.dart';
import 'package:book_app/modules/auth/controller/auth_controller.dart';
import 'package:book_app/modules/auth/repository/api/api_auth_repository.dart';
import 'package:book_app/modules/auth/repository/api/api_user_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:book_app/modules/auth/service/auth_service.dart';
import 'package:book_app/modules/books/book_module.dart';
import 'package:book_app/modules/comment_post/comment_module.dart';
import 'package:book_app/modules/book_details/details_module.dart';
import 'package:book_app/modules/book_details/page/details_page.dart';
import 'package:book_app/modules/favoritas/favoritas_module.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/home/home_module.dart';
import 'package:book_app/modules/primeiro_acesso/primeiro_acesso_controller.dart';
import 'package:book_app/modules/primeiro_acesso/primeiro_acesso_module.dart';
import 'package:book_app/shared/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => SplashScreen());
    r.module('/auth', module: AuthModule());
    r.module('/primeiro-acesso', module: PrimeiroAcessoModule());
    r.module('/initial', module: HomeModule());
  }
}
