// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on _AuthControllerBase, Store {
  late final _$isLoginAtom =
      Atom(name: '_AuthControllerBase.isLogin', context: context);

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$titleAtom =
      Atom(name: '_AuthControllerBase.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$botaoCadastrarAtom =
      Atom(name: '_AuthControllerBase.botaoCadastrar', context: context);

  @override
  String get botaoCadastrar {
    _$botaoCadastrarAtom.reportRead();
    return super.botaoCadastrar;
  }

  @override
  set botaoCadastrar(String value) {
    _$botaoCadastrarAtom.reportWrite(value, super.botaoCadastrar, () {
      super.botaoCadastrar = value;
    });
  }

  late final _$userIsAuthenticateAtom =
      Atom(name: '_AuthControllerBase.userIsAuthenticate', context: context);

  @override
  bool get userIsAuthenticate {
    _$userIsAuthenticateAtom.reportRead();
    return super.userIsAuthenticate;
  }

  @override
  set userIsAuthenticate(bool value) {
    _$userIsAuthenticateAtom.reportWrite(value, super.userIsAuthenticate, () {
      super.userIsAuthenticate = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthControllerBase.login', context: context);

  @override
  Future login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$createuserAsyncAction =
      AsyncAction('_AuthControllerBase.createuser', context: context);

  @override
  Future createuser() {
    return _$createuserAsyncAction.run(() => super.createuser());
  }

  late final _$signOutAsyncAction =
      AsyncAction('_AuthControllerBase.signOut', context: context);

  @override
  Future signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  late final _$_AuthControllerBaseActionController =
      ActionController(name: '_AuthControllerBase', context: context);

  @override
  void toggleRegistrar() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.toggleRegistrar');
    try {
      return super.toggleRegistrar();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
title: ${title},
botaoCadastrar: ${botaoCadastrar},
userIsAuthenticate: ${userIsAuthenticate}
    ''';
  }
}
