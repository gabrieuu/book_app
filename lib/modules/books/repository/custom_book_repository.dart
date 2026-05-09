import 'package:book_app/model/book_detail_model.dart';
import 'package:book_app/model/book_model.dart';

abstract class BookRepository {
  Future<List<BookModel>> fetchAll(String volume, {int? page});
  Future<BookDetailModel> getBookById(String id);
  Future<List<BookModel>> getBooksByCategory(String category);
  Future<List<BookModel>> getBooksByListId(List<String> listIdBooks);
  Future<List<BookModel>> getBooksRecomendados();
  Future<List<BookModel>> getBooksByAutor(String autor);
  Future<List<BookModel>> getBooksByEditora(String editora);
  Future<List<BookModel>> getBooksByIsbn(String isbn);
}
