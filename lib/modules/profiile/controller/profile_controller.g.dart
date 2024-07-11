// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileController on _ProfileControllerBase, Store {
  late final _$userControllerAtom =
      Atom(name: '_ProfileControllerBase.userController', context: context);

  @override
  UserController get userController {
    _$userControllerAtom.reportRead();
    return super.userController;
  }

  @override
  set userController(UserController value) {
    _$userControllerAtom.reportWrite(value, super.userController, () {
      super.userController = value;
    });
  }

  late final _$favoritasStoreAtom =
      Atom(name: '_ProfileControllerBase.favoritasStore', context: context);

  @override
  FavoritasStore get favoritasStore {
    _$favoritasStoreAtom.reportRead();
    return super.favoritasStore;
  }

  @override
  set favoritasStore(FavoritasStore value) {
    _$favoritasStoreAtom.reportWrite(value, super.favoritasStore, () {
      super.favoritasStore = value;
    });
  }

  @override
  String toString() {
    return '''
userController: ${userController},
favoritasStore: ${favoritasStore}
    ''';
  }
}
