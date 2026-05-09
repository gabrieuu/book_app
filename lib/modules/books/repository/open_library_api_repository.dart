import 'package:book_app/core/client_http/client_http.dart';
import 'package:book_app/model/book_detail_model.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';

class OpenLibraryApiRepository implements BookRepository {
  final ClientHttp client;
  final String baseUrlSearch = 'https://openlibrary.org/search.json';

  OpenLibraryApiRepository(this.client);

  @override
  Future<List<BookModel>> fetchAll(String volume, {int? page = 1}) async{
    final response = await client.get(baseUrlSearch, params: {
      'title': volume,
      'page': page,
      'limit': 20,

    });
    final docs = response['docs'] as List<dynamic>;

    if(docs.isEmpty) return <BookModel>[];

    return docs.where((doc) => doc['cover_i'] != null).map((doc) => BookModel.fromOpenLibrary(doc)).toList();
  }

  @override
  Future<BookDetailModel> getBookById(String id) async{
    final response = await client.get('https://openlibrary.org/$id.json');
    return BookDetailModel.fromOpenLibrary(response);
  }

  @override
  Future<List<BookModel>> getBooksByAutor(String autor) async {
    return [];
  }

  @override
  Future<List<BookModel>> getBooksByCategory(String category) async{
    return [];
  }

  @override
  Future<List<BookModel>> getBooksByEditora(String editora) async{
    return [];
  }

  @override
  Future<List<BookModel>> getBooksByIsbn(String isbn) async {
    return [];
  }

  @override
  Future<List<BookModel>> getBooksByListId(List<String> listIdBooks) async{
    return [];
  }

  @override
  Future<List<BookModel>> getBooksRecomendados() async{
    return [];
  }
  
}