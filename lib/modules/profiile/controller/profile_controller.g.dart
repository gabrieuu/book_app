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

  late final _$postStoreAtom =
      Atom(name: '_ProfileControllerBase.postStore', context: context);

  @override
  PostStore get postStore {
    _$postStoreAtom.reportRead();
    return super.postStore;
  }

  @override
  set postStore(PostStore value) {
    _$postStoreAtom.reportWrite(value, super.postStore, () {
      super.postStore = value;
    });
  }

  late final _$myPostsAtom =
      Atom(name: '_ProfileControllerBase.myPosts', context: context);

  @override
  ObservableList<PostModel> get myPosts {
    _$myPostsAtom.reportRead();
    return super.myPosts;
  }

  @override
  set myPosts(ObservableList<PostModel> value) {
    _$myPostsAtom.reportWrite(value, super.myPosts, () {
      super.myPosts = value;
    });
  }

  late final _$myFavoritasAtom =
      Atom(name: '_ProfileControllerBase.myFavoritas', context: context);

  @override
  ObservableList<Book> get myFavoritas {
    _$myFavoritasAtom.reportRead();
    return super.myFavoritas;
  }

  @override
  set myFavoritas(ObservableList<Book> value) {
    _$myFavoritasAtom.reportWrite(value, super.myFavoritas, () {
      super.myFavoritas = value;
    });
  }

  late final _$situacaoPostAtom =
      Atom(name: '_ProfileControllerBase.situacaoPost', context: context);

  @override
  Status get situacaoPost {
    _$situacaoPostAtom.reportRead();
    return super.situacaoPost;
  }

  @override
  set situacaoPost(Status value) {
    _$situacaoPostAtom.reportWrite(value, super.situacaoPost, () {
      super.situacaoPost = value;
    });
  }

  late final _$situacaoFavoritosAtom =
      Atom(name: '_ProfileControllerBase.situacaoFavoritos', context: context);

  @override
  Status get situacaoFavoritos {
    _$situacaoFavoritosAtom.reportRead();
    return super.situacaoFavoritos;
  }

  @override
  set situacaoFavoritos(Status value) {
    _$situacaoFavoritosAtom.reportWrite(value, super.situacaoFavoritos, () {
      super.situacaoFavoritos = value;
    });
  }

  late final _$getPostsByUserIdAsyncAction =
      AsyncAction('_ProfileControllerBase.getPostsByUserId', context: context);

  @override
  Future getPostsByUserId({String? userId}) {
    return _$getPostsByUserIdAsyncAction
        .run(() => super.getPostsByUserId(userId: userId));
  }

  late final _$getFavoritosByUserIdAsyncAction = AsyncAction(
      '_ProfileControllerBase.getFavoritosByUserId',
      context: context);

  @override
  Future getFavoritosByUserId({String? userId}) {
    return _$getFavoritosByUserIdAsyncAction
        .run(() => super.getFavoritosByUserId(userId: userId));
  }

  @override
  String toString() {
    return '''
userController: ${userController},
postStore: ${postStore},
myPosts: ${myPosts},
myFavoritas: ${myFavoritas},
situacaoPost: ${situacaoPost},
situacaoFavoritos: ${situacaoFavoritos}
    ''';
  }
}
