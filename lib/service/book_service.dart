import 'package:book_app/model/book.dart';
import 'package:book_app/service/client_http/client_http.dart';

class BookService{
  ClientHttp client;

  BookService(this.client);

  Future<List<Book>> fetchAll(String volume) async{
    final url = "https://www.googleapis.com/books/v1/volumes?q=$volume";
    final response = await client.get(url);
    final  list = response["items"] as List;
    return list.map((map) => Book.fromMap(map)).toList();
  }
}