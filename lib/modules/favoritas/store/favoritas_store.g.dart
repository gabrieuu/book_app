// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoritas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritasStore on _FavoritasStoreBase, Store {
  late final _$favoritasLoadingAtom =
      Atom(name: '_FavoritasStoreBase.favoritasLoading', context: context);

  @override
  Status get favoritasLoading {
    _$favoritasLoadingAtom.reportRead();
    return super.favoritasLoading;
  }

  @override
  set favoritasLoading(Status value) {
    _$favoritasLoadingAtom.reportWrite(value, super.favoritasLoading, () {
      super.favoritasLoading = value;
    });
  }

  late final _$listBooksFavoritesAtom =
      Atom(name: '_FavoritasStoreBase.listBooksFavorites', context: context);

  @override
  ObservableList<Book> get listBooksFavorites {
    _$listBooksFavoritesAtom.reportRead();
    return super.listBooksFavorites;
  }

  @override
  set listBooksFavorites(ObservableList<Book> value) {
    _$listBooksFavoritesAtom.reportWrite(value, super.listBooksFavorites, () {
      super.listBooksFavorites = value;
    });
  }

  late final _$addFavoriteAsyncAction =
      AsyncAction('_FavoritasStoreBase.addFavorite', context: context);

  @override
  Future<void> addFavorite(Book book) {
    return _$addFavoriteAsyncAction.run(() => super.addFavorite(book));
  }

  late final _$getBooksFavoritesAsyncAction =
      AsyncAction('_FavoritasStoreBase.getBooksFavorites', context: context);

  @override
  Future<void> getBooksFavorites() {
    return _$getBooksFavoritesAsyncAction.run(() => super.getBooksFavorites());
  }

  late final _$removeFavoritaAsyncAction =
      AsyncAction('_FavoritasStoreBase.removeFavorita', context: context);

  @override
  Future removeFavorita(Book book) {
    return _$removeFavoritaAsyncAction.run(() => super.removeFavorita(book));
  }

  late final _$_FavoritasStoreBaseActionController =
      ActionController(name: '_FavoritasStoreBase', context: context);

  @override
  bool isFavorita(Book book) {
    final _$actionInfo = _$_FavoritasStoreBaseActionController.startAction(
        name: '_FavoritasStoreBase.isFavorita');
    try {
      return super.isFavorita(book);
    } finally {
      _$_FavoritasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoritasLoading: ${favoritasLoading},
listBooksFavorites: ${listBooksFavorites}
    ''';
  }
}
