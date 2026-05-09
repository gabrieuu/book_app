// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'busca_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BuscaController on _BuscaControllerBase, Store {
  late final _$tabBarSelecionadaAtom =
      Atom(name: '_BuscaControllerBase.tabBarSelecionada', context: context);

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

  late final _$leitoresEncrontradosAtom =
      Atom(name: '_BuscaControllerBase.leitoresEncrontrados', context: context);

  @override
  ObservableList<UserModel> get leitoresEncrontrados {
    _$leitoresEncrontradosAtom.reportRead();
    return super.leitoresEncrontrados;
  }

  @override
  set leitoresEncrontrados(ObservableList<UserModel> value) {
    _$leitoresEncrontradosAtom.reportWrite(value, super.leitoresEncrontrados,
        () {
      super.leitoresEncrontrados = value;
    });
  }

  late final _$livrosEncontradosAtom =
      Atom(name: '_BuscaControllerBase.livrosEncontrados', context: context);

  @override
  ObservableList<BookModel> get livrosEncontrados {
    _$livrosEncontradosAtom.reportRead();
    return super.livrosEncontrados;
  }

  @override
  set livrosEncontrados(ObservableList<BookModel> value) {
    _$livrosEncontradosAtom.reportWrite(value, super.livrosEncontrados, () {
      super.livrosEncontrados = value;
    });
  }

  late final _$statusLeitoresCarregandoAtom = Atom(
      name: '_BuscaControllerBase.statusLeitoresCarregando', context: context);

  @override
  Status get statusLeitoresCarregando {
    _$statusLeitoresCarregandoAtom.reportRead();
    return super.statusLeitoresCarregando;
  }

  @override
  set statusLeitoresCarregando(Status value) {
    _$statusLeitoresCarregandoAtom
        .reportWrite(value, super.statusLeitoresCarregando, () {
      super.statusLeitoresCarregando = value;
    });
  }

  late final _$statusLivrosCarregandoAtom = Atom(
      name: '_BuscaControllerBase.statusLivrosCarregando', context: context);

  @override
  Status get statusLivrosCarregando {
    _$statusLivrosCarregandoAtom.reportRead();
    return super.statusLivrosCarregando;
  }

  @override
  set statusLivrosCarregando(Status value) {
    _$statusLivrosCarregandoAtom
        .reportWrite(value, super.statusLivrosCarregando, () {
      super.statusLivrosCarregando = value;
    });
  }

  late final _$isSearchingAtom =
      Atom(name: '_BuscaControllerBase.isSearching', context: context);

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  late final _$buscarPorTabBarAsyncAction =
      AsyncAction('_BuscaControllerBase.buscarPorTabBar', context: context);

  @override
  Future<void> buscarPorTabBar(int value) {
    return _$buscarPorTabBarAsyncAction.run(() => super.buscarPorTabBar(value));
  }

  late final _$buscarAsyncAction =
      AsyncAction('_BuscaControllerBase.buscar', context: context);

  @override
  Future<void> buscar({String? value}) {
    return _$buscarAsyncAction.run(() => super.buscar(value: value));
  }

  late final _$buscaLeitoresAsyncAction =
      AsyncAction('_BuscaControllerBase.buscaLeitores', context: context);

  @override
  Future<void> buscaLeitores(String name) {
    return _$buscaLeitoresAsyncAction.run(() => super.buscaLeitores(name));
  }

  late final _$buscaLivrosAsyncAction =
      AsyncAction('_BuscaControllerBase.buscaLivros', context: context);

  @override
  Future<void> buscaLivros(String nome) {
    return _$buscaLivrosAsyncAction.run(() => super.buscaLivros(nome));
  }

  late final _$_BuscaControllerBaseActionController =
      ActionController(name: '_BuscaControllerBase', context: context);

  @override
  void clear() {
    final _$actionInfo = _$_BuscaControllerBaseActionController.startAction(
        name: '_BuscaControllerBase.clear');
    try {
      return super.clear();
    } finally {
      _$_BuscaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tabBarSelecionada: ${tabBarSelecionada},
leitoresEncrontrados: ${leitoresEncrontrados},
livrosEncontrados: ${livrosEncontrados},
statusLeitoresCarregando: ${statusLeitoresCarregando},
statusLivrosCarregando: ${statusLivrosCarregando},
isSearching: ${isSearching}
    ''';
  }
}
