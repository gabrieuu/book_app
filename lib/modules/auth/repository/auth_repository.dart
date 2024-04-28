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

  AuthRepository(){
    _supabaseUser = supabase.auth.currentUser;
  }

  Future<void> createUser(String name, String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      await supabase.from(Table.usuarios.name).insert({
        'id_user': res.user!.id, 
        'name': name,
        'email': email,
        'password': password,
      });      
      _supabaseSession = res.session;
      _supabaseUser = res.user;
    } catch (e) {
      print("erro ao criar conta");
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final response = await supabase
          .from(Table.usuarios.name)
          .select("*")
          .eq("email", email);
      if (response != null) {
        final AuthResponse res = await supabase.auth
            .signInWithPassword(email: email, password: password);
        _supabaseSession = res.session;
        _supabaseUser = res.user;
      }
    } catch (e) {
      print("erro ao logar");
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      print("erro ao sair");
    }
  }
}