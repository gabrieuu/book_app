import 'package:book_app/core/client_http/dio_client.dart';
import 'package:book_app/modules/books/repository/book_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final repository = BookRepository(DioClient());
  
  test('buscar por categoria', () async{
    var response = await repository.fetchCategory('romance');
    print(response);
  });
}