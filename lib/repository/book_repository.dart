import 'package:book_app/model/book.dart';
import 'package:book_app/service/book_service.dart';
import 'package:book_app/service/client_http/dio_client.dart';

class BookRepository{
  List<Book> books = [];
  final _service = BookService(DioClient());

  Future<List<Book>> fetchAllBooks(String book) async{
    return books = await _service.fetchAll(book);
  }
}