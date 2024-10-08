
import 'package:book_app/model/book_model.dart';
import 'package:book_app/core/client_http/client_http.dart';
import 'package:book_app/database/bd_book.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepository{
  ClientHttp client;
  //BDBook bdBook = BDBook();
  final supabase = Supabase.instance.client;

  BookRepository(this.client);

  Future<List<Book>> fetchAll(String volume) async{
     if(volume.trim().length > 3){
       final url = "https://www.googleapis.com/books/v1/volumes?q=$volume&maxResults=20&orderBy=relevance";
      final response =await client.get(url);
      var listBooks = (response['items'] as List).map((e) => Book.fromMap(e)).toList();
      listBooks.removeWhere((element) => (element.volumeInfo.description == null || element.volumeInfo.imageLinks == null));
      return (response['items'] as List).map((map) => Book.fromMap(map)).toList();
     }

     return [];
  }

  Future<List<Book>> fetchCategory(String category) async{
    final url = "https://www.googleapis.com/books/v1/volumes?q=subject:$category&filter=partial&printType=books";
    final response = await client.get(url);
    var listBooks = (response['items'] as List).map((e) => Book.fromMap(e)).toList();
    listBooks.removeWhere((element) => (element.volumeInfo.description == null || element.volumeInfo.imageLinks == null));
    return listBooks;
  }

  Future<List<Book>> getBooksByListId(List<String> listIdBooks) async{
    List<Book> listBooks = [];
    var futures = listIdBooks.map((e) => client.get("https://www.googleapis.com/books/v1/volumes/$e"));
    List<Map<String,dynamic>> responses = List<Map<String,dynamic>>.from(await Future.wait(futures));

    for (var element in responses) {
        Book book = Book.fromMap(element);
        book.isFavorite = true;
        listBooks.add(book); 
    }
    return listBooks;
  }

  Future<List<Book>> getBooksRecomendados() async{
    
    try {
      var response = await supabase.from("recomendados").select("id_book");
      List<String> listIdsBooks = (response as List).map((e) => e['id_book'].toString()).toList();
      return await getBooksByListId(listIdsBooks);
    } catch (e) {
      print(e);
    }
    
    return [];
  }

}