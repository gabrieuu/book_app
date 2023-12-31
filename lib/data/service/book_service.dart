
import 'package:book_app/data/model/book_model.dart';
import 'package:book_app/data/service/client_http/client_http.dart';

class BookService{
  ClientHttp client;

  BookService(this.client);

  Future<List<Book>> fetchAll(String volume) async{
    final url = "https://www.googleapis.com/books/v1/volumes?q=$volume";
    final response = await client.get(url);
    final  list = response["items"] as List;
    return list.map((map) => Book.fromMap(map)).toList();
  }

  Future<List<Book>> fetchFavoritesBooks(List<String> listIdBooks) async{
    List<Book> listBooks = [];
    for(int i = 0; i < listIdBooks.length; i++){
       try {
        final url = "https://www.googleapis.com/books/v1/volumes?q=${listIdBooks[i]}";
        final response = await client.get(url);
        
        if(response["items"] != null){
          final list = response["items"] as List;
          listBooks.add(Book.fromMap(list.first));
        }
       } catch (e) {
         print(e);
       }
    }

    return listBooks;
  }
}