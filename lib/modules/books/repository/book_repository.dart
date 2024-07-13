
import 'package:book_app/model/book_model.dart';
import 'package:book_app/core/client_http/client_http.dart';
import 'package:book_app/database/bd_book.dart';

class BookRepository{
  ClientHttp client;
  BDBook bdBook = BDBook();

  BookRepository(this.client);

  Future<List<Book>> fetchAll(String volume) async{
    List? list = bdBook.getBooks();
    if(list == null || list[0] != volume){
      final url = "https://www.googleapis.com/books/v1/volumes?q=$volume&maxResults=20&orderBy=relevance";
      final response = await client.get(url);
      list = ['',response["items"] as List];
      print(list.last);
      bdBook.addBook(key: volume, listBooks: response["items"]);
    }

    return (list.last as List).map((map) => Book.fromMap(map)).toList();
   
  }

  Future<List<Book>> fetchCategory(String category) async{
    final url = "https://www.googleapis.com/books/v1/volumes?q=subject:$category&maxResults=10&orderBy=newest";
    final response = await client.get(url);
    var a = (response['items'] as List).map((e) => Book.fromMap(e)).toList();
    return a;
  }

  Future<List<Book>> fetchFavoritesBooks(List<String> listIdBooks) async{
    List<Book> listBooks = [];
    var futures = listIdBooks.map((e) => client.get("https://www.googleapis.com/books/v1/volumes/$e"));
    List<Map<String,dynamic>> responses = List<Map<String,dynamic>>.from(await Future.wait(futures));
    
    responses.forEach((response) {
        Book book = Book.fromMap(response);
        book.isFavorite = true;
        listBooks.add(book);    
    });

    return listBooks;
  }
}