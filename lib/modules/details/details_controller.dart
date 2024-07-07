import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'details_controller.g.dart';

class DetailsController = _DetailsControllerBase with _$DetailsController;

abstract class _DetailsControllerBase with Store {
  FavoritaRepository repository = Modular.get();

  @observable
  Book? book;

  @observable
  BookStore store = Modular.get();

  @observable
  FavoritasStore favoritasStore = Modular.get();
  _DetailsControllerBase();

  @action
  addFavorite(Book book) async{
    await repository.addFavorite(book.id);
  }

  @action
  removeFavorita(Book book) async{  
    await repository.removeFavorita(book.id);
  }

  @action
  Future<bool> isFavorita(Book book) async{
    return repository.isFavorita(book);
  }
}