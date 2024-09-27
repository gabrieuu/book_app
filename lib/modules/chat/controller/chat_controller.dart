import 'dart:async';
import 'dart:developer';

import 'package:book_app/core/status.dart';
import 'package:book_app/model/chat_model.dart';
import 'package:book_app/model/dto/view_chats_dto.dart';
import 'package:book_app/model/mensagem.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/chat/repository/chat_repository.dart';
import 'package:book_app/modules/chat/repository/custom_chat_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'chat_controller.g.dart';

class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  @observable
  ObservableList<ChatsViewDto> chats = ObservableList.of([]);

  @observable
  Status carregandoChats = Status.NAO_CARREGADO;

  CustomChatRepository chatRepository;
  UserController userController;
  StreamSubscription? chatStream;

  _ChatControllerBase(this.userController, this.chatRepository) {
    chatStream = Supabase.instance.client
        .from(CHAT_TABLE)
        .stream(primaryKey: ['id']).listen((data) {
      getAllChats();
    });
  }

  @action
  Future<void> getAllChats() async {
    try {
      carregandoChats = Status.CARREGANDO;
      chats = ObservableList.of(await chatRepository
          .getChatsPrivadoDoUsuario(userController.user.id!));
      carregandoChats = Status.SUCESSO;
    } catch (e) {
      chats = ObservableList.of([]);
      carregandoChats = Status.ERRO;
    }
  }

  @action
  Future<void> updateChatPorId(String chatId) async {
    try {
      var chat = await chatRepository.getChatPorId(chatId);
      var index = chats.indexWhere((element) => element.chatId == chatId);
      chats[index] = chat;
    } catch (e) {
      print('erro ao atualizar chat');
    }
  }

  @computed
  int get mensagensNaoVisualizadas {
    int count = 0;

    for (var chat in chats) {
      if (!chat.visualizado! &&
          chat.idDoUsuarioQueEnviouUltimaMsg != userController.user.id!) {
        count++;
      }
    }

    return count;
  }
}
