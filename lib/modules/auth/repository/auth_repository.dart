import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobx/mobx.dart';

enum Table {
  usuarios,
}

class AuthRepository {
  final supabase = Supabase.instance.client;

  @observable
  User? _supabaseUser;

  @observable
  Session? _supabaseSession;

  User? get user => _supabaseUser;

  AuthRepository() {
    _supabaseUser = supabase.auth.currentUser;
  }

  Future<void> createUser({required String email, required String password}) async {
    String passEncript = md5.convert(password.codeUnits).toString();
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: passEncript,
    );
    await supabase.from(Table.usuarios.name).insert({
      'id_user': res.user!.id,
      'email': email,
      'password': passEncript,
    });
    _supabaseSession = res.session;
    _supabaseUser = res.user;
  }

  Future<void> signIn(String email, String password) async {
    String passEncript = md5.convert(password.codeUnits).toString();
    final response =
        await supabase.from(Table.usuarios.name).select("*").eq("email", email);
    if (response != null) {
      final AuthResponse res = await supabase.auth
          .signInWithPassword(email: email, password: passEncript);

      _supabaseSession = res.session;
      _supabaseUser = res.user;
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
