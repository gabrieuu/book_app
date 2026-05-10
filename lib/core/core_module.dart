import 'package:book_app/app_store.dart';
import 'package:book_app/infra/client_http/client_http.dart';
import 'package:book_app/infra/client_http/dio_client.dart';
import 'package:book_app/modules/auth/controller/auth_controller.dart';
import 'package:book_app/modules/auth/repository/api/api_auth_repository.dart';
import 'package:book_app/modules/auth/repository/api/api_user_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:book_app/modules/auth/service/auth_service.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<BottomNavigatorController>(
        BottomNavigatorController.new);
    i.addLazySingleton<ClientHttp>(DioClient.new);
    i.addLazySingleton<AppStore>(AppStore.new);

    i.addLazySingleton<CustomAuthRepository>(ApiAuthRepository.new);
    i.addLazySingleton<CustomUserRepository>(ApiUserRepository.new);
    i.addLazySingleton<AuthService>(AuthService.new);
    i.addLazySingleton<AuthController>(AuthController.new);
  }

}