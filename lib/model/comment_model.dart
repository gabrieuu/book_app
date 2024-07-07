class CommentModel {
  String? id;
  String content;
  int idPost;
  String autorId;

  CommentModel(
      {this.id,
      required this.content,
      required this.idPost,
      required this.autorId});

  static CommentModel fromJson(Map<String, dynamic> map) {
    return CommentModel(
        id: map['id'],
        content: map['content'],
        idPost: map['id_post'],
        autorId: map['autor_id']);
  }

  Map<String, dynamic> toJson() {
    return {"content": content, "id_post": idPost, "autor_id": autorId};
  }
}
