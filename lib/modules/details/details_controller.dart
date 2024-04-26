import 'package:book_app/core/model/book_model.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:book_app/modules/home/store/book_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'details_controller.g.dart';

class DetailsController = _DetailsControllerBase with _$DetailsController;

abstract class _DetailsControllerBase with Store {
  FavoritaRepository repository;
  BookStore store = Modular.get();
  _DetailsControllerBase(this.repository);

  @action
  addFavorite(Book book) async{
    await repository.addFavorite(book.id);
    store.listBooks.where((element ) => element.id == book.id).first.isFavorite = !store.listBooks.where((element ) => element.id == book.id).first.isFavorite;
  }
}