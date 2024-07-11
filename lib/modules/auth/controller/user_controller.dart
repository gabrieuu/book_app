import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:mobx/mobx.dart';
part 'user_controller.g.dart';

class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store {

  @observable
  UserModel? _user;

  UserRepository repository;

  _UserControllerBase(this.repository){
    init();
  }
  
  @action
  init() async{
    await getUsers();
  }
   @action
  getUsers() async{
    _user = await repository.getUserById();
  }

  UserModel get user => _user!;
}