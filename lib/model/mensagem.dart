class Mensagem {
  String? id;
  String chatId;
  String userId;
  String content;
  DateTime? dataEnviada;

  Mensagem(
      {this.id,
      required this.chatId,
      required this.userId,
      required this.content,
      this.dataEnviada});

  Map<String, dynamic> toJson() {
    return {'chat_id': chatId, 'user_id': userId, 'content': content};
  }

  static Mensagem fromJson(Map<String, dynamic> map) {
    return Mensagem(
      id: map['id'],
      chatId: map['chat_id'],
      userId: map['user_id'],
      content: map['content'],
      dataEnviada: DateTime.parse(map['data_enviada']),
    );
  }
}
