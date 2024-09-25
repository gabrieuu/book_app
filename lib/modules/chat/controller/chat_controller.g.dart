// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatController on _ChatControllerBase, Store {
  Computed<int>? _$mensagensNaoVisualizadasComputed;

  @override
  int get mensagensNaoVisualizadas => (_$mensagensNaoVisualizadasComputed ??=
          Computed<int>(() => super.mensagensNaoVisualizadas,
              name: '_ChatControllerBase.mensagensNaoVisualizadas'))
      .value;

  late final _$chatsAtom =
      Atom(name: '_ChatControllerBase.chats', context: context);

  @override
  ObservableList<ChatsViewDto> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableList<ChatsViewDto> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  late final _$carregandoChatsAtom =
      Atom(name: '_ChatControllerBase.carregandoChats', context: context);

  @override
  Status get carregandoChats {
    _$carregandoChatsAtom.reportRead();
    return super.carregandoChats;
  }

  @override
  set carregandoChats(Status value) {
    _$carregandoChatsAtom.reportWrite(value, super.carregandoChats, () {
      super.carregandoChats = value;
    });
  }

  late final _$getAllChatsAsyncAction =
      AsyncAction('_ChatControllerBase.getAllChats', context: context);

  @override
  Future<void> getAllChats() {
    return _$getAllChatsAsyncAction.run(() => super.getAllChats());
  }

  late final _$updateChatPorIdAsyncAction =
      AsyncAction('_ChatControllerBase.updateChatPorId', context: context);

  @override
  Future<void> updateChatPorId(String chatId) {
    return _$updateChatPorIdAsyncAction
        .run(() => super.updateChatPorId(chatId));
  }

  @override
  String toString() {
    return '''
chats: ${chats},
carregandoChats: ${carregandoChats},
mensagensNaoVisualizadas: ${mensagensNaoVisualizadas}
    ''';
  }
}
