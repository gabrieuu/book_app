import 'package:book_app/model/images.dart';

class PostModel {
  int? id;
  String content;
  String? bookId;
  List<Images>? images;
  String autorId;
  String? autorName;
  int quantidadeCurtidas;
  int quantidadeComentarios;
  bool isCurtido;
  DateTime createdAt;

  PostModel(
      {required this.content,
      this.autorName,
      this.bookId,
      this.id,
      required this.autorId,
      this.images,
      this.quantidadeCurtidas = 0,
      this.quantidadeComentarios = 0,
      DateTime? createdAt,
      this.isCurtido = false})
      : createdAt = createdAt ?? DateTime.now();

  static PostModel fromJson(Map<dynamic, dynamic> map) {
    final post = PostModel(
        id: map['id'],
        content: map['content'],
        autorId: map['autor_id'],
        autorName: map['usuarios']['name'],
        bookId: map['book_id'],
        quantidadeCurtidas: map['curtidas'] ?? 0,
        quantidadeComentarios: map['comentarios'] ?? 0,
        createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toString()));
    return post;
  }

  Map<dynamic, dynamic> get toJson {
    return {
      'content': content,
      'book_id': bookId,
      'autor_id': autorId,
    };
  }
}
