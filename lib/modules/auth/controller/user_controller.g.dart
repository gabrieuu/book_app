// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserController on _UserControllerBase, Store {
  late final _$_userAtom =
      Atom(name: '_UserControllerBase._user', context: context);

  @override
  UserModel? get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(UserModel? value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$usersSearchedAtom =
      Atom(name: '_UserControllerBase.usersSearched', context: context);

  @override
  ObservableList<UserModel> get usersSearched {
    _$usersSearchedAtom.reportRead();
    return super.usersSearched;
  }

  @override
  set usersSearched(ObservableList<UserModel> value) {
    _$usersSearchedAtom.reportWrite(value, super.usersSearched, () {
      super.usersSearched = value;
    });
  }

  late final _$usersSearchedsAtom =
      Atom(name: '_UserControllerBase.usersSearcheds', context: context);

  @override
  Status get usersSearcheds {
    _$usersSearchedsAtom.reportRead();
    return super.usersSearcheds;
  }

  @override
  set usersSearcheds(Status value) {
    _$usersSearchedsAtom.reportWrite(value, super.usersSearcheds, () {
      super.usersSearcheds = value;
    });
  }

  late final _$getUserAsyncAction =
      AsyncAction('_UserControllerBase.getUser', context: context);

  @override
  Future<UserModel?> getUser({String? userId}) {
    return _$getUserAsyncAction.run(() => super.getUser(userId: userId));
  }

  late final _$getAllUsersAsyncAction =
      AsyncAction('_UserControllerBase.getAllUsers', context: context);

  @override
  Future getAllUsers(String name) {
    return _$getAllUsersAsyncAction.run(() => super.getAllUsers(name));
  }

  @override
  String toString() {
    return '''
usersSearched: ${usersSearched},
usersSearcheds: ${usersSearcheds}
    ''';
  }
}
