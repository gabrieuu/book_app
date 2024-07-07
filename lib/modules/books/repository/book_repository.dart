
import 'package:book_app/model/book_model.dart';
import 'package:book_app/core/client_http/client_http.dart';
import 'package:book_app/database/bd_book.dart';

class BookRepository{
  ClientHttp client;
  final bdBook = BDBook.instance;

  BookRepository(this.client);

  Future<List<Book>> fetchAll(String volume) async{
    List? list = bdBook.getBooks;
    if(list == null || list[0] != volume){
      final url = "https://www.googleapis.com/books/v1/volumes?q=$volume";
      final response = await client.get(url);
      list = ['',response["items"] as List];
      print(list.last);
      bdBook.addBook(key: volume, listBooks: response["items"]);
    }
    return (list.last as List).map((map) => Book.fromMap(map)).toList();
   
  }

  Future<List<Book>> fetchFavoritesBooks(List<String> listIdBooks) async{
    List<Book> listBooks = [];
    for(int i = 0; i < listIdBooks.length; i++){
       try {
        final url = "https://www.googleapis.com/books/v1/volumes?q=${listIdBooks[i]}";
        final response = await client.get(url);
        
        if(response["items"] != null){
          final list = response["items"] as List;
          Book book = Book.fromMap(list.first);
          book.isFavorite = true;
          listBooks.add(book);
        }
       } catch (e) {
         print(e);
       }
    }

    return listBooks;
  }
}