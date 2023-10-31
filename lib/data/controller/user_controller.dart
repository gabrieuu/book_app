import 'package:book_app/data/model/user_model.dart';
import 'package:book_app/data/service/user_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController{

  UserModel? _user;
  final service = UserService();

  getUsers() async{
    _user = await service.getUserById();
  }

  UserModel get user => _user!;
  static UserController get to => Get.find<UserController>();
}