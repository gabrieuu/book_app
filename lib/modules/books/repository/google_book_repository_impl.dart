import 'package:book_app/infra/client_http/client_http.dart';
import 'package:book_app/model/book_detail_model.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';
import 'package:book_app/modules/books/repository/dto/google_book_api/google_book_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleBookRepositoryImpl implements BookRepository {
  final ClientHttp client;
  final supabase = Supabase.instance.client;

  GoogleBookRepositoryImpl(this.client);

  @override
  Future<List<BookModel>> fetchAll(String volume, {int? page}) async {
    if (volume.trim().length > 3) {
      final url =
          "https://www.googleapis.com/books/v1/volumes?q=intitle:$volume&maxResults=20&orderBy=relevance&printType=books&projection=full&langRestrict=pt";
      final response = await client.get(url);
      var listBooks =
          (response['items'] as List).map((e) => GoogleBookDTO.fromMap(e)).toList();
      listBooks.removeWhere(
          (element) => (element.volumeInfo.contemDadoNull() == true));
      return [];
    }

    return [];
  }

  @override
  Future<BookDetailModel> getBookById(String id)async {
    final response = client
        .get("https://www.googleapis.com/books/v1/volumes/$id")
        .then((value) => GoogleBookDTO.fromMap(value));
    throw UnimplementedError();
  }

  @override
  Future<List<BookModel>> getBooksByCategory(String category) async {
    final url =
        "https://www.googleapis.com/books/v1/volumes?q=subject:$category&orderBy=relevance&printType=books&maxResults=10&langRestrict=pt";
    final response = await client.get(url);
    var listBooks =
        (response['items'] as List).map((e) => GoogleBookDTO.fromMap(e)).toList();
    listBooks
        .removeWhere((element) => (element.volumeInfo.description == null));
    return [];
  }

  @override
  Future<List<BookModel>> getBooksByListId(List<String> listIdBooks) async {
    List<GoogleBookDTO> listBooks = [];
    var futures = listIdBooks.map(
        (e) => client.get("https://www.googleapis.com/books/v1/volumes/$e"));
    List<Map<String, dynamic>> responses =
        List<Map<String, dynamic>>.from(await Future.wait(futures));

    for (var element in responses) {
      GoogleBookDTO book = GoogleBookDTO.fromMap(element);
      book.isFavorite = true;
      listBooks.add(book);
    }
    return [];
  }

  @override
  Future<List<BookModel>> getBooksRecomendados() async {
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
  Future<List<BookModel>> getBooksByAutor(String autor) async {
    if (autor.trim().length > 3) {
      final url =
          "https://www.googleapis.com/books/v1/volumes?q=inauthor:$autor&orderBy=relevance&printType=books&projection=full";
      final response = await client.get(url);
      var listBooks =
          (response['items'] as List).map((e) => GoogleBookDTO.fromMap(e)).toList();
      listBooks.removeWhere(
          (element) => (element.volumeInfo.contemDadoNull() == true));
      return [];
    }

    return [];
  }

  @override
  Future<List<BookModel>> getBooksByEditora(String editora) async {
    if (editora.trim().length > 3) {
      final url =
          "https://www.googleapis.com/books/v1/volumes?q=inpublisher:$editora&orderBy=relevance&printType=books&projection=full";
      final response = await client.get(url);
      var listBooks =
          (response['items'] as List).map((e) => GoogleBookDTO.fromMap(e)).toList();
      listBooks.removeWhere(
          (element) => (element.volumeInfo.contemDadoNull() == true));
      return [];
    }

    return [];
  }

  @override
  Future<List<BookModel>> getBooksByIsbn(String isbn) async {
    if (isbn.trim().length > 3) {
      final url =
          "https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn&orderBy=relevance&printType=books&projection=full";
      final response = await client.get(url);
      var listBooks =
          (response['items'] as List).map((e) => GoogleBookDTO.fromMap(e)).toList();
      listBooks.removeWhere(
          (element) => (element.volumeInfo.contemDadoNull() == true));
      return [];
    }

    return [];
  }
}
