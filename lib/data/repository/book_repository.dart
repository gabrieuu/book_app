import 'package:book_app/data/model/book.dart';
import 'package:book_app/data/service/book_service.dart';
import 'package:book_app/data/service/client_http/client_http.dart';
import 'package:book_app/data/service/client_http/dio_client.dart';
import 'package:flutter/widgets.dart';

class BookRepository{
  List<Book> books = [];
  final _service = BookService(DioClient() as ClientHttp);

  TextEditingController searchBook = TextEditingController();

  Future<List<Book>> fetchAllBooks(String book) async{
    return books = await _service.fetchAll(book);
  }
}