import 'package:book_app/infra/client_http/dio_client.dart';
import 'package:book_app/modules/books/repository/google_book_repository_impl.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  BookRepository repository = GoogleBookRepositoryImpl(DioClient());

  test('buscar por categoria', () async {
    var response = await repository.fetchCategory('romance');
    print(response);
  });

  test('buscar recomendados', () async {
    var response = await repository.getBooksRecomendados();
  });
}
