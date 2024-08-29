// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primeiro_acesso_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PrimeiroAcessoController on _PrimeiroAcessoControllerBase, Store {
  late final _$indexSelecionadoAtom = Atom(
      name: '_PrimeiroAcessoControllerBase.indexSelecionado', context: context);

  @override
  int get indexSelecionado {
    _$indexSelecionadoAtom.reportRead();
    return super.indexSelecionado;
  }

  @override
  set indexSelecionado(int value) {
    _$indexSelecionadoAtom.reportWrite(value, super.indexSelecionado, () {
      super.indexSelecionado = value;
    });
  }

  late final _$alteraNomeAndUsernameAsyncAction = AsyncAction(
      '_PrimeiroAcessoControllerBase.alteraNomeAndUsername',
      context: context);

  @override
  Future<void> alteraNomeAndUsername() {
    return _$alteraNomeAndUsernameAsyncAction
        .run(() => super.alteraNomeAndUsername());
  }

  late final _$_PrimeiroAcessoControllerBaseActionController =
      ActionController(name: '_PrimeiroAcessoControllerBase', context: context);

  @override
  void proximoIndex() {
    final _$actionInfo = _$_PrimeiroAcessoControllerBaseActionController
        .startAction(name: '_PrimeiroAcessoControllerBase.proximoIndex');
    try {
      return super.proximoIndex();
    } finally {
      _$_PrimeiroAcessoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
indexSelecionado: ${indexSelecionado}
    ''';
  }
}
