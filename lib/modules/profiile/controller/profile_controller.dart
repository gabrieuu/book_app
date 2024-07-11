import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:mobx/mobx.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {

  @observable
  UserController userController;
  
  @observable
  FavoritasStore favoritasStore;

  _ProfileControllerBase({
    required this.userController,
    required this.favoritasStore
  });


}