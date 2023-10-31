import 'package:book_app/data/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum Table {
  usuarios,
}

class AuthService extends GetxController {
  //Session? session;
  final supabase = Supabase.instance.client;
  final Rx<User?> _supabaseUser = Rx<User?>(null);
  final Rx<Session?> _supabaseSession = Rx<Session?>(null);
  var userIsAuthenticate = false.obs;

  User? get user => _supabaseUser.value;
  static AuthService get to => Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _supabaseUser.value = supabase.auth.currentUser;
    
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      if(event == AuthChangeEvent.signedIn) {
        userIsAuthenticate.value = true;
        UserController.to.getUsers();
      }
      else if(event == AuthChangeEvent.signedOut || event == AuthChangeEvent.tokenRefreshed){
        userIsAuthenticate.value = false;
      }
    });
  }

  createUser(String name, String email, String password) async {
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
      _supabaseSession.value = res.session;
      _supabaseUser.value = res.user;
    } catch (e) {
      print("erro ao criar conta");
    }
  }

  signIn(String email, String password) async {
    try {
      final response = await supabase
          .from(Table.usuarios.name)
          .select("*")
          .eq("email", email);
      if (response != null) {
        final AuthResponse res = await supabase.auth
            .signInWithPassword(email: email, password: password);
        _supabaseSession.value = res.session;
        _supabaseUser.value = res.user;
      }
    } catch (e) {
      print("erro ao logar");
    }
  }

  

  signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      print("erro ao sair");
    }
  }
}
