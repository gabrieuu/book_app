import 'package:book_app/model/book_model.dart';

abstract class CustomBookRepository {
  Future<List<Book>> fetchAll(String volume);
  Future<List<Book>> fetchCategory(String category);
  Future<List<Book>> getBooksByListId(List<String> listIdBooks);
  Future<List<Book>> getBooksRecomendados();
}
