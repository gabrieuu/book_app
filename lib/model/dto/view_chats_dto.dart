class ChatsViewDto {
  String? id;
  DateTime? dataCriacao;
  String nomeDoUsuario;
  String usernameDoUsuario;
  String userId;
  String? lastMessage;

  ChatsViewDto(
      {this.id,
      this.dataCriacao,
      required this.nomeDoUsuario,
      required this.usernameDoUsuario,
      required this.userId,
      this.lastMessage});

  static ChatsViewDto fromJson(Map<String, dynamic> map) {
    return ChatsViewDto(
        id: map['id'],
        dataCriacao: DateTime.parse(map['data_criacao']),
        nomeDoUsuario: map['name'],
        usernameDoUsuario: map['username'],
        userId: map['id_user'],
        lastMessage: map['content'] ?? '');
  }
}
