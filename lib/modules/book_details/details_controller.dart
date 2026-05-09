import 'package:book_app/core/status.dart';
import 'package:book_app/model/book_detail_model.dart';
import 'package:book_app/modules/books/repository/custom_book_repository.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:mobx/mobx.dart';
part 'details_controller.g.dart';

class DetailsController = _DetailsControllerBase with _$DetailsController;

abstract class _DetailsControllerBase with Store {

  @observable
  late BookDetailModel book;

  @observable
  BookStore store;
  
  @observable
  Status status = Status.NAO_CARREGADO;

  final BookRepository repository;  

  _DetailsControllerBase({
    required this.store,
    required this.repository,
  });

  @action
  Future<void> loadBookDetails(String apiId) async {
    try {
      status = Status.CARREGANDO;
      book = await repository.getBookById(apiId);
      status = Status.SUCESSO;
    } catch (e) {
      print('Erro ao carregar detalhes do livro: $e');
      status = Status.ERRO;
    }
  }
}