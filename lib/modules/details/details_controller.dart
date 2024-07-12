import 'package:book_app/model/book_model.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'details_controller.g.dart';

class DetailsController = _DetailsControllerBase with _$DetailsController;

abstract class _DetailsControllerBase with Store {

  @observable
  Book? book;

  @observable
  BookStore store;

  _DetailsControllerBase({
    required this.store
  });
}