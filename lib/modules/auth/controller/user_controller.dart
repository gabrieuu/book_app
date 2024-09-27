import 'package:book_app/core/status.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'user_controller.g.dart';

class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store {
  @observable
  UserModel? _user;
  CustomAuthRepository authRepository;
  CustomUserRepository repository;

  _UserControllerBase(this.repository, this.authRepository);

  @action
  Future<UserModel?> getUser({String? userId}) async {
    UserModel user =
        await repository.getUserById(userId ?? authRepository.user!.id!);
    if (userId == null) {
      _user = user;
      return null;
    }
    return user;
  }

  @action
  getAllUsers(String name) async {
    ObservableList.of(await repository.getUsersByName(name));
  }

  UserModel get user => _user!;
}
