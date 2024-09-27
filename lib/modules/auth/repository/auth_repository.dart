import 'dart:convert';

import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_auth_repository.dart';
import 'package:book_app/modules/auth/repository/interfaces/custom_user_repository.dart';
import 'package:book_app/modules/auth/repository/user_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobx/mobx.dart';

enum Table {
  usuarios,
}

class AuthRepositorySupabase implements CustomAuthRepository {
  final supabase = Supabase.instance.client;

  User? _supabaseUser;

  CustomUserRepository userRepository;

  @override
  UserModel? get user =>
      UserModel.buildUser(id: _supabaseUser!.id, email: _supabaseUser!.email);

  AuthRepositorySupabase(this.userRepository) {
    _supabaseUser = supabase.auth.currentUser;
  }

  @override
  Future<void> createUser(
      {required String email, required String password}) async {
    String passEncript = md5.convert(password.codeUnits).toString();
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: passEncript,
    );
    if (res.user == null) throw Exception("Erro ao criar usuário");
    await userRepository.createUser(
        idUser: res.user!.id, email: email, password: password);
    _supabaseUser = res.user;
  }

  @override
  Future<void> signIn(String email, String password) async {
    String passEncript = md5.convert(password.codeUnits).toString();
    final response =
        await supabase.from(Table.usuarios.name).select("*").eq("email", email);
    if (response.isNotEmpty) {
      final AuthResponse res = await supabase.auth
          .signInWithPassword(email: email, password: passEncript);
      _supabaseUser = res.user;
    }
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
