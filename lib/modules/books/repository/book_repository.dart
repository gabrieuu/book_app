import 'package:book_app/auth/secrets.dart';
import 'package:book_app/core/client_http/client_http.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepositoryImpl implements CustomBookRepository {
  final ClientHttp client;
  final supabase = Supabase.instance.client;

  BookRepositoryImpl(this.client);

  @override
  Future<List<Book>> fetchAll(String volume) async {
    if (volume.trim().length > 3) {
      final url =
          "https://www.googleapis.com/books/v1/volumes?q=intitle:$volume&maxResults=20&orderBy=relevance&printType=books&projection=full&langRestrict=pt&key=$apiGoogleBoksKey";
      final response = await client.get(url);
      var listBooks =
          (response['items'] as List).map((e) => Book.fromMap(e)).toList();
      listBooks.removeWhere(
          (element) => (element.volumeInfo.contemDadoNull() == true));
      return listBooks;
    }

    return [];
  }

  @override
  Future<List<Book>> getBooksByCategory(String category) async {
    final url =
        "https://www.googleapis.com/books/v1/volumes?q=subject:$category&orderBy=relevance&printType=books&maxResults=10&langRestrict=pt&key=$apiGoogleBoksKey";
    final response = await client.get(url);
    var listBooks =
        (response['items'] as List).map((e) => Book.fromMap(e)).toList();
    listBooks
        .removeWhere((element) => (element.volumeInfo.description == null));
    return listBooks;
  }

  @override
  Future<List<Book>> getBooksByListId(List<String> listIdBooks) async {
    List<Book> listBooks = [];
    var futures = listIdBooks.map(
        (e) => client.get("https://www.googleapis.com/books/v1/volumes/$e"));
    List<Map<String, dynamic>> responses =
        List<Map<String, dynamic>>.from(await Future.wait(futures));

    for (var element in responses) {
      Book book = Book.fromMap(element);
      book.isFavorite = true;
      listBooks.add(book);
    }
    return listBooks;
  }

  @override
  Future<List<Book>> getBooksRecomendados() async {
    try {
      var response = await supabase.from("recomendados").select("id_book");
      List<String> listIdsBooks =
          (response as List).map((e) => e['id_book'].toString()).toList();
      return await getBooksByListId(listIdsBooks);
    } catch (e) {
      print(e);
    }

    return [];
  }

  @override
  Future<List<Book>> getBooksByAutor(String autor) async {
    if (autor.trim().length > 3) {
      final url =
          "https://www.googleapis.com/books/v1/volumes?q=inauthor:$autor&orderBy=relevance&printType=books&projection=full&key=$apiGoogleBoksKey";
      final response = await client.get(url);
      var listBooks =
          (response['items'] as List).map((e) => Book.fromMap(e)).toList();
      listBooks.removeWhere(
          (element) => (element.volumeInfo.contemDadoNull() == true));
      return listBooks;
    }

    return [];
  }

  @override
  Future<List<Book>> getBooksByEditora(String editora) async {
    if (editora.trim().length > 3) {
      final url =
          "https://www.googleapis.com/books/v1/volumes?q=inpublisher:$editora&orderBy=relevance&printType=books&projection=full&key=$apiGoogleBoksKey";
      final response = await client.get(url);
      var listBooks =
          (response['items'] as List).map((e) => Book.fromMap(e)).toList();
      listBooks.removeWhere(
          (element) => (element.volumeInfo.contemDadoNull() == true));
      return listBooks;
    }

    return [];
  }

  @override
  Future<List<Book>> getBooksByIsbn(String isbn) async {
    if (isbn.trim().length > 3) {
      final url =
          "https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn&orderBy=relevance&printType=books&projection=full&key=$apiGoogleBoksKey";
      final response = await client.get(url);
      var listBooks =
          (response['items'] as List).map((e) => Book.fromMap(e)).toList();
      listBooks.removeWhere(
          (element) => (element.volumeInfo.contemDadoNull() == true));
      return listBooks;
    }

    return [];
  }
}
