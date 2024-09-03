// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensagens_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MensagemController on _MensagemControllerBase, Store {
  late final _$idChatAtom =
      Atom(name: '_MensagemControllerBase.idChat', context: context);

  @override
  String? get idChat {
    _$idChatAtom.reportRead();
    return super.idChat;
  }

  @override
  set idChat(String? value) {
    _$idChatAtom.reportWrite(value, super.idChat, () {
      super.idChat = value;
    });
  }

  late final _$mensagensAtom =
      Atom(name: '_MensagemControllerBase.mensagens', context: context);

  @override
  ObservableList<Mensagem> get mensagens {
    _$mensagensAtom.reportRead();
    return super.mensagens;
  }

  @override
  set mensagens(ObservableList<Mensagem> value) {
    _$mensagensAtom.reportWrite(value, super.mensagens, () {
      super.mensagens = value;
    });
  }

  late final _$carregandoMensagensAtom = Atom(
      name: '_MensagemControllerBase.carregandoMensagens', context: context);

  @override
  Status get carregandoMensagens {
    _$carregandoMensagensAtom.reportRead();
    return super.carregandoMensagens;
  }

  @override
  set carregandoMensagens(Status value) {
    _$carregandoMensagensAtom.reportWrite(value, super.carregandoMensagens, () {
      super.carregandoMensagens = value;
    });
  }

  late final _$mensagensStreamAtom =
      Atom(name: '_MensagemControllerBase.mensagensStream', context: context);

  @override
  StreamSubscription<dynamic> get mensagensStream {
    _$mensagensStreamAtom.reportRead();
    return super.mensagensStream;
  }

  bool _mensagensStreamIsInitialized = false;

  @override
  set mensagensStream(StreamSubscription<dynamic> value) {
    _$mensagensStreamAtom.reportWrite(
        value, _mensagensStreamIsInitialized ? super.mensagensStream : null,
        () {
      super.mensagensStream = value;
      _mensagensStreamIsInitialized = true;
    });
  }

  late final _$getAllMessagesAsyncAction =
      AsyncAction('_MensagemControllerBase.getAllMessages', context: context);

  @override
  Future<void> getAllMessages(String id) {
    return _$getAllMessagesAsyncAction.run(() => super.getAllMessages(id));
  }

  @override
  String toString() {
    return '''
idChat: ${idChat},
mensagens: ${mensagens},
carregandoMensagens: ${carregandoMensagens},
mensagensStream: ${mensagensStream}
    ''';
  }
}
