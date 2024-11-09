import 'package:book_app/model/dto/view_chats_dto.dart';
import 'package:book_app/model/mensagem.dart';

abstract class CustomChatRepository {
  Future<void> adicionarParticipantes(
      {required String usuario1, required usuario2});

  Future<List<ChatsViewDto>> getChatsPrivadoDoUsuario(String userId);

  Future<ChatsViewDto> getChatPorId(String chatId);

  Future<void> visualizarMensagem(
      {required String userId, required String chatId});

  Future<void> sendMessage(Mensagem mensagem);

  Future<String?> getChatId(String userId, String userId2);

  Future<String> createChat(
      {String? nomeChat, required String usuario1, required usuario2});

  Future<String> iniciarConversa({required String usuario1, required usuario2});

  Future<List<Mensagem>> getMensagems({required String chatId});
}
