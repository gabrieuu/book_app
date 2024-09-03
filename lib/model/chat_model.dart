class ChatModel {
  String id;
  String nome;
  bool isGrupo;

  ChatModel({required this.id, required this.nome, required this.isGrupo});

  static ChatModel fromJson(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      isGrupo: map['isGrupo'] ?? '',
    );
  }
}
