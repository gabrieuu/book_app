class ChatsViewDto {
  String? id;
  DateTime? dataCriacao;
  String nomeDoUsuario;
  String usernameDoUsuario;
  String userId;
  String? lastMessage;
  bool? visualizado;
  String? idDoUsuarioQueEnviouUltimaMsg;

  ChatsViewDto(
      {this.id,
      this.dataCriacao,
      required this.nomeDoUsuario,
      required this.usernameDoUsuario,
      required this.userId,
      this.lastMessage,
      this.visualizado,
      this.idDoUsuarioQueEnviouUltimaMsg});

  static ChatsViewDto fromJson(Map<String, dynamic> map) {
    return ChatsViewDto(
        id: map['id'],
        dataCriacao: DateTime.parse(map['data_criacao']),
        nomeDoUsuario: map['name'],
        usernameDoUsuario: map['username'],
        userId: map['id_user'],
        lastMessage: map['content'] ?? '',
        visualizado: map['visualizado'],
        idDoUsuarioQueEnviouUltimaMsg:
            map['id_do_usuario_que_enviou_ultima_msg']);
  }
}
