
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum Table {
  usuarios,
}

class AuthRepositorySupabase implements CustomAuthRepository {
  final supabase = Supabase.instance.client;
  User? _supabaseUser;
  CustomUserRepository userRepository;

  @override
  Future<UserModel?> get user async{
    _supabaseUser = supabase.auth.currentUser;
    if(_supabaseUser == null) return null;

    final response = await supabase.from(Table.usuarios.name).select("*").eq("id_user", _supabaseUser!.id);
    if(response.isEmpty){
      return UserModel.buildUser(id: _supabaseUser!.id, email: _supabaseUser!.email);
    }
    return UserModel.fromMap(response.first);
  }

  AuthRepositorySupabase(this.userRepository);

  @override
  Future<UserModel> createUser(
      {required String email, required String password}) async {
    String passEncript = md5.convert(password.codeUnits).toString();
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: passEncript,
    );
    if (res.user == null) throw Exception("Erro ao criar usuário");
    await userRepository.createUser(
        idUser: res.user!.id, email: email, password: passEncript);
    _supabaseUser = res.user;
    return UserModel.buildUser(id: res.user!.id, email: res.user!.email);
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    String passEncript = md5.convert(password.codeUnits).toString();
    final response =
        await supabase.from(Table.usuarios.name).select("*").eq("email", email).eq("password", passEncript);
    if (response.isEmpty) {
      throw Exception("Usuário não encontrado, verifique suas credenciais.");
    }
    final AuthResponse res = await supabase.auth
          .signInWithPassword(email: email, password: passEncript);

    if (res.user == null) throw Exception("Erro ao fazer login");
    _supabaseUser = res.user;
    return UserModel.buildUser(id: res.user!.id, email: res.user!.email);
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
