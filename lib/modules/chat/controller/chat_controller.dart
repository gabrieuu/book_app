import 'dart:async';
import 'dart:developer';

import 'package:book_app/core/status.dart';
import 'package:book_app/model/chat_model.dart';
import 'package:book_app/model/dto/view_chats_dto.dart';
import 'package:book_app/model/mensagem.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/service/auth_service.dart';
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
  StreamSubscription? chatStream;
  final AuthService _authService;

  _ChatControllerBase(this.chatRepository, this._authService) {
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
      UserModel? user = _authService.currentUser;
      if(user == null) throw Exception("Usuário não autenticado");
      chats = ObservableList.of(await chatRepository
          .getChatsPrivadoDoUsuario(user.id!));
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

    return count;
  }
}
