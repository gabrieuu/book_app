// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileController on _ProfileControllerBase, Store {
  Computed<double>? _$getAlturaTabbarComputed;

  @override
  double get getAlturaTabbar => (_$getAlturaTabbarComputed ??= Computed<double>(
          () => super.getAlturaTabbar,
          name: '_ProfileControllerBase.getAlturaTabbar'))
      .value;

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

  late final _$quantidadeSeguidoresAtom = Atom(
      name: '_ProfileControllerBase.quantidadeSeguidores', context: context);

  @override
  int get quantidadeSeguidores {
    _$quantidadeSeguidoresAtom.reportRead();
    return super.quantidadeSeguidores;
  }

  @override
  set quantidadeSeguidores(int value) {
    _$quantidadeSeguidoresAtom.reportWrite(value, super.quantidadeSeguidores,
        () {
      super.quantidadeSeguidores = value;
    });
  }

  late final _$quantidadeSeguindoAtom =
      Atom(name: '_ProfileControllerBase.quantidadeSeguindo', context: context);

  @override
  int get quantidadeSeguindo {
    _$quantidadeSeguindoAtom.reportRead();
    return super.quantidadeSeguindo;
  }

  @override
  set quantidadeSeguindo(int value) {
    _$quantidadeSeguindoAtom.reportWrite(value, super.quantidadeSeguindo, () {
      super.quantidadeSeguindo = value;
    });
  }

  late final _$tabBarSelecionadaAtom =
      Atom(name: '_ProfileControllerBase.tabBarSelecionada', context: context);

  @override
  int get tabBarSelecionada {
    _$tabBarSelecionadaAtom.reportRead();
    return super.tabBarSelecionada;
  }

  @override
  set tabBarSelecionada(int value) {
    _$tabBarSelecionadaAtom.reportWrite(value, super.tabBarSelecionada, () {
      super.tabBarSelecionada = value;
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

  late final _$isSeguindoAtom =
      Atom(name: '_ProfileControllerBase.isSeguindo', context: context);

  @override
  bool get isSeguindo {
    _$isSeguindoAtom.reportRead();
    return super.isSeguindo;
  }

  @override
  set isSeguindo(bool value) {
    _$isSeguindoAtom.reportWrite(value, super.isSeguindo, () {
      super.isSeguindo = value;
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

  late final _$listSeguidoresAtom =
      Atom(name: '_ProfileControllerBase.listSeguidores', context: context);

  @override
  List<UserModel> get listSeguidores {
    _$listSeguidoresAtom.reportRead();
    return super.listSeguidores;
  }

  @override
  set listSeguidores(List<UserModel> value) {
    _$listSeguidoresAtom.reportWrite(value, super.listSeguidores, () {
      super.listSeguidores = value;
    });
  }

  late final _$listSeguindoAtom =
      Atom(name: '_ProfileControllerBase.listSeguindo', context: context);

  @override
  List<UserModel> get listSeguindo {
    _$listSeguindoAtom.reportRead();
    return super.listSeguindo;
  }

  @override
  set listSeguindo(List<UserModel> value) {
    _$listSeguindoAtom.reportWrite(value, super.listSeguindo, () {
      super.listSeguindo = value;
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

  late final _$initAsyncAction =
      AsyncAction('_ProfileControllerBase.init', context: context);

  @override
  Future<void> init(String? userId) {
    return _$initAsyncAction.run(() => super.init(userId));
  }

  late final _$getSeguidoresAsyncAction =
      AsyncAction('_ProfileControllerBase.getSeguidores', context: context);

  @override
  Future<void> getSeguidores(String? userId) {
    return _$getSeguidoresAsyncAction.run(() => super.getSeguidores(userId));
  }

  late final _$getSeguindoAsyncAction =
      AsyncAction('_ProfileControllerBase.getSeguindo', context: context);

  @override
  Future<void> getSeguindo(String? userId) {
    return _$getSeguindoAsyncAction.run(() => super.getSeguindo(userId));
  }

  late final _$getIsSeguindoAsyncAction =
      AsyncAction('_ProfileControllerBase.getIsSeguindo', context: context);

  @override
  Future<void> getIsSeguindo(String? userId) {
    return _$getIsSeguindoAsyncAction.run(() => super.getIsSeguindo(userId));
  }

  late final _$getPostsByUserIdAsyncAction =
      AsyncAction('_ProfileControllerBase.getPostsByUserId', context: context);

  @override
  Future<void> getPostsByUserId({String? userId}) {
    return _$getPostsByUserIdAsyncAction
        .run(() => super.getPostsByUserId(userId: userId));
  }

  late final _$getFavoritosByUserIdAsyncAction = AsyncAction(
      '_ProfileControllerBase.getFavoritosByUserId',
      context: context);

  @override
  Future<void> getFavoritosByUserId({String? userId}) {
    return _$getFavoritosByUserIdAsyncAction
        .run(() => super.getFavoritosByUserId(userId: userId));
  }

  late final _$seguirPessoaAsyncAction =
      AsyncAction('_ProfileControllerBase.seguirPessoa', context: context);

  @override
  Future seguirPessoa(String pessoaIdSeguida) {
    return _$seguirPessoaAsyncAction
        .run(() => super.seguirPessoa(pessoaIdSeguida));
  }

  late final _$getQuantidadeSeguidoresAsyncAction = AsyncAction(
      '_ProfileControllerBase.getQuantidadeSeguidores',
      context: context);

  @override
  Future<void> getQuantidadeSeguidores(String? userId) {
    return _$getQuantidadeSeguidoresAsyncAction
        .run(() => super.getQuantidadeSeguidores(userId));
  }

  late final _$getQuantidadeSeguindoAsyncAction = AsyncAction(
      '_ProfileControllerBase.getQuantidadeSeguindo',
      context: context);

  @override
  Future<void> getQuantidadeSeguindo(String? userId) {
    return _$getQuantidadeSeguindoAsyncAction
        .run(() => super.getQuantidadeSeguindo(userId));
  }

  @override
  String toString() {
    return '''
userController: ${userController},
quantidadeSeguidores: ${quantidadeSeguidores},
quantidadeSeguindo: ${quantidadeSeguindo},
tabBarSelecionada: ${tabBarSelecionada},
postStore: ${postStore},
isSeguindo: ${isSeguindo},
myPosts: ${myPosts},
myFavoritas: ${myFavoritas},
listSeguidores: ${listSeguidores},
listSeguindo: ${listSeguindo},
situacaoPost: ${situacaoPost},
situacaoFavoritos: ${situacaoFavoritos},
getAlturaTabbar: ${getAlturaTabbar}
    ''';
  }
}
