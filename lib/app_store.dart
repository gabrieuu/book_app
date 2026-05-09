import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/service/auth_service.dart';
import 'package:mobx/mobx.dart';
part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  final AuthService _authService;

  _AppStoreBase(this._authService);

  UserModel? _currentUser;

  UserModel? get currentUser {
    _currentUser ??= _authService.currentUser;
    return _currentUser;
  }
}