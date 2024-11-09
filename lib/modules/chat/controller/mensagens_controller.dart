import 'dart:async';
import 'dart:developer';

import 'package:book_app/core/status.dart';
import 'package:book_app/model/mensagem.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/chat/controller/chat_controller.dart';
import 'package:book_app/modules/chat/repository/custom_chat_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'mensagens_controller.g.dart';

class MensagemController = _MensagemControllerBase with _$MensagemController;

abstract class _MensagemControllerBase with Store {
  @observable
  String? idChat;

  @observable
  String? friendId;

  @observable
  bool isChatOpen = false;

  @observable
  ObservableList<Mensagem> mensagens = ObservableList.of([]);

  CustomChatRepository chatRepository;
  UserController userController;

  ChatController chatController;
  UserModel? user;

  @observable
  Status carregandoMensagens = Status.NAO_CARREGADO;

  StreamSubscription<List<Map<String, dynamic>>>? chatStream;
  Timer? _debounce;
  _MensagemControllerBase(
      this.chatRepository, this.userController, this.chatController) {
    chatStream = Supabase.instance.client
        .from('mensagens')
        .stream(primaryKey: ['id']).listen((data) async {
      for (var mensagemJson in data) {
        var mensagem = Mensagem.fromJson(mensagemJson);
        if (idChat != null && mensagem.chatId == idChat!) {
          var mensagemExistente = mensagens.firstWhere(
              (element) => element.id == mensagem.id,
              orElse: () => Mensagem.nulo());
          if (mensagemExistente.chatId == '') {
            mensagens.add(mensagem);
          } else {
            var index =
                mensagens.indexWhere((element) => element.id == mensagem.id);
            mensagens[index] = mensagem;
          }
        }
      }
      // chatController.getAllChats();
      mensagens.sort((a, b) => b.dataEnviada!.compareTo(a.dataEnviada!));

      _onNewMessagesProcessed();
    });
  }

  void _onNewMessagesProcessed() {
    // Se já existir um debounce ativo, cancelamos ele
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    // Defina um intervalo de tempo (exemplo: 500ms) antes de processar as funções
    _debounce = Timer(Duration(milliseconds: 500), () async {
      chatController.updateChatPorId(idChat!);
      if (isChatOpen == true && friendId != null) {
        await visualizarMensagem(friendId!);
      }
    });
  }

  @action
  Future<void> visualizarMensagem(String userId) async {
    await chatRepository.visualizarMensagem(userId: userId, chatId: idChat!);
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
