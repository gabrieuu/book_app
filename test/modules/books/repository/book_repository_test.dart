import 'package:book_app/core/client_http/dio_client.dart';
import 'package:book_app/modules/books/repository/book_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  final repository = BookRepository(DioClient());
  
  test('buscar por categoria', () async{
    var response = await repository.fetchCategory('romance');
    print(response);
  });

  test('buscar recomendados', () async{
    var response = await repository.getBooksRecomendados();
  });

}