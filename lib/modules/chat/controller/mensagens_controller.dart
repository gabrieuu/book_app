import 'dart:async';
import 'dart:developer';

import 'package:book_app/core/status.dart';
import 'package:book_app/model/mensagem.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/chat/chat_repository.dart';
import 'package:book_app/modules/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'mensagens_controller.g.dart';

class MensagemController = _MensagemControllerBase with _$MensagemController;

abstract class _MensagemControllerBase with Store {
  @observable
  String? idChat;

  @observable
  ObservableList<Mensagem> mensagens = ObservableList.of([]);

  ChatRepository chatRepository;
  UserController userController;

  ChatController chatController;
  UserModel? user;

  @observable
  Status carregandoMensagens = Status.NAO_CARREGADO;

  @observable
  late StreamSubscription mensagensStream;

  _MensagemControllerBase(
      this.chatRepository, this.userController, this.chatController) {
    mensagensStream = Supabase.instance.client
        .from('mensagens')
        .stream(primaryKey: ['id']).listen((data) {
      mensagens.clear();
      for (var mensagemJson in data) {
        var mensagem = Mensagem.fromJson(mensagemJson);
        if (idChat != null && mensagem.chatId == idChat) {
          mensagens.add(mensagem);
          chatController.getAllChats();
        }
      }
      mensagens.sort((a, b) => b.dataEnviada!.compareTo(a.dataEnviada!));
    });
  }

  @action
  Future<void> getAllMessages(String id) async {
    try {
      carregandoMensagens = Status.CARREGANDO;
      idChat = await chatRepository.iniciarConversa(
          usuario1: userController.user.id!, usuario2: id);
      mensagens =
          ObservableList.of(await chatRepository.getMensagems(chatId: idChat!));
      mensagens.sort((a, b) => b.dataEnviada!.compareTo(a.dataEnviada!));
      carregandoMensagens = Status.SUCESSO;
    } catch (e) {
      log('erro ao carregar mensagens');
      carregandoMensagens = Status.ERRO;
    }
  }

  Future<void> sendMessage(String conteudo) async {
    try {
      await chatRepository.sendMessage(Mensagem(
          chatId: idChat!, userId: userController.user.id!, content: conteudo));
    } catch (e) {
      log('erro ao enviar mensagem');
    }
  }
}
