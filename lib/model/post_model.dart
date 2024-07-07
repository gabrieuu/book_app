import 'package:book_app/model/images.dart';

class PostModel {
  int? id;
  String content;
  String? bookId;
  List<Images>? images;
  String autorId;
  String? autorName;

  PostModel(
      {required this.content, this.autorName, this.bookId, this.id, required this.autorId, this.images});

  static PostModel fromJson(Map<dynamic, dynamic> map) {
    final post = PostModel(
        id: map['id'],
        content: map['content'],
        autorId: map['autor_id'],
        autorName: map['usuarios']['name'],
        bookId: map['book_id'],
      );
    return post;
  }

  Map<dynamic, dynamic> get toJson {
    return {
      'content': content,
      'book_id' : bookId,
      'autor_id' : autorId,
    };
  }
}
