import 'dart:developer';
import 'package:book_app/model/dto/view_chats_dto.dart';
import 'package:book_app/model/mensagem.dart';
import 'package:book_app/modules/chat/repository/custom_chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String CHAT_TABLE = 'chat';
const String MESSAGES_TABLE = 'mensagens';
const String CHAT_PARTICIPANTS_TABLE = 'chat_participantes';
const String CHAT_VIEW = 'list_chats_view';

class ChatRepositorySupabase implements CustomChatRepository {
  final client = Supabase.instance.client;

  @override
  Future<void> adicionarParticipantes(
      {required String usuario1, required usuario2}) async {}

  @override
  Future<List<ChatsViewDto>> getChatsPrivadoDoUsuario(String userId) async {
    var response = await client
        .from(CHAT_PARTICIPANTS_TABLE)
        .select('chat_id')
        .eq('id_user', userId);

    if (response.isEmpty) return [];

    List<ChatsViewDto> chats = [];

    try {
      for (var element in response) {
        var chates = await client
            .from(CHAT_VIEW)
            .select('*')
            .eq('chat_id', element['chat_id'])
            .neq('id_user', userId)
            .limit(1);
        chats.add(ChatsViewDto.fromJson(chates[0]));
      }
    } catch (e) {
      log('erro ao adicionar chats');
    }

    return chats;
  }

  @override
  Future<ChatsViewDto> getChatPorId(String chatId) {
    return client
        .from(CHAT_VIEW)
        .select('*')
        .eq('chat_id', chatId)
        .limit(1)
        .then((value) => ChatsViewDto.fromJson(value[0]));
  }

  @override
  Future<void> visualizarMensagem(
      {required String userId, required String chatId}) async {
    try {
      await client
          .from(MESSAGES_TABLE)
          .update({'visualizado': true})
          .eq('user_id', userId)
          .eq('chat_id', chatId);
    } catch (e) {
      log('$e');
    }
  }

  @override
  Future<void> sendMessage(Mensagem mensagem) async {
    await client.from(MESSAGES_TABLE).insert(mensagem.toJson());
  }

  @override
  Future<String?> getChatId(String userId, String userId2) async {
    var listaDeChatsIds = await client
        .from(CHAT_PARTICIPANTS_TABLE)
        .select('chat_id')
        .eq('id_user', userId);

    for (var element in listaDeChatsIds) {
      String chatId = element['chat_id'];
      var outrosParticipantes = await client
          .from(CHAT_PARTICIPANTS_TABLE)
          .select('id_user')
          .eq('chat_id', chatId)
          .neq('id_user', userId);

      if (outrosParticipantes[0]['id_user'] == userId2 &&
          outrosParticipantes.isNotEmpty) {
        return chatId;
      }
    }

    return null;
  }

  @override
  Future<String> createChat(
      {String? nomeChat, required String usuario1, required usuario2}) async {
    final response =
        await client.from(CHAT_TABLE).insert({'nome': nomeChat}).select('id');

    String chatId = response[0]['id'];
    await client.from(CHAT_PARTICIPANTS_TABLE).insert([
      {'chat_id': chatId, 'id_user': usuario1},
      {'chat_id': chatId, 'id_user': usuario2}
    ]);

    return chatId;
  }

  @override
  Future<String> iniciarConversa(
      {required String usuario1, required usuario2}) async {
    String? chatId = await getChatId(usuario1, usuario2);
    return chatId ?? await createChat(usuario1: usuario1, usuario2: usuario2);
  }

  @override
  Future<List<Mensagem>> getMensagems({required String chatId}) async {
    try {
      final response =
          await client.from(MESSAGES_TABLE).select('*').eq('chat_id', chatId);

      final List<Mensagem> mensagens =
          (response as List).map((e) => Mensagem.fromJson(e)).toList();

      return mensagens;
    } catch (e) {
      log('$e');
      return [];
    }
  }
}
