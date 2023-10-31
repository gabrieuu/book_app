import 'package:book_app/data/model/user_model.dart';
import 'package:book_app/data/service/auth_service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService{

  final client = Supabase.instance.client;

  Future<UserModel?> getUserById() async{
    final user = await client.from("usuarios").select("*").eq("id_user", AuthService.to.user!.id);
    return UserModel.fromMap(user[0]);
  }
}