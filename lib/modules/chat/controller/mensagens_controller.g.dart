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

  late final _$friendIdAtom =
      Atom(name: '_MensagemControllerBase.friendId', context: context);

  @override
  String? get friendId {
    _$friendIdAtom.reportRead();
    return super.friendId;
  }

  @override
  set friendId(String? value) {
    _$friendIdAtom.reportWrite(value, super.friendId, () {
      super.friendId = value;
    });
  }

  late final _$isChatOpenAtom =
      Atom(name: '_MensagemControllerBase.isChatOpen', context: context);

  @override
  bool get isChatOpen {
    _$isChatOpenAtom.reportRead();
    return super.isChatOpen;
  }

  @override
  set isChatOpen(bool value) {
    _$isChatOpenAtom.reportWrite(value, super.isChatOpen, () {
      super.isChatOpen = value;
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

  late final _$visualizarMensagemAsyncAction = AsyncAction(
      '_MensagemControllerBase.visualizarMensagem',
      context: context);

  @override
  Future<void> visualizarMensagem(String userId) {
    return _$visualizarMensagemAsyncAction
        .run(() => super.visualizarMensagem(userId));
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
friendId: ${friendId},
isChatOpen: ${isChatOpen},
mensagens: ${mensagens},
carregandoMensagens: ${carregandoMensagens}
    ''';
  }
}
