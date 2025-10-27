import 'package:book_app/model/book_model.dart';

abstract class CustomBookRepository {
  Future<List<Book>> fetchAll(String volume);
  Future<List<Book>> getBooksByCategory(String category);
  Future<List<Book>> getBooksByListId(List<String> listIdBooks);
  Future<List<Book>> getBooksRecomendados();
  Future<List<Book>> getBooksByAutor(String autor);
  Future<List<Book>> getBooksByEditora(String editora);
  Future<List<Book>> getBooksByIsbn(String isbn);
  Future<Book?> getBookById(String id);
}
