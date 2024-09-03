class ChatParticipantes {
  String id;
  String chatId;
  String userId;

  ChatParticipantes(
      {required this.id, required this.chatId, required this.userId});

  static ChatParticipantes fromJson(Map<String, dynamic> map) {
    return ChatParticipantes(
      id: map['id'],
      chatId: map['chat_id'],
      userId: map['id_user'],
    );
  }
}
