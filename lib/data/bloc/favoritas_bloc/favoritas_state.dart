import 'package:book_app/data/model/book_model.dart';

abstract class FavoritasState{}

class LoadingFavoritasState extends FavoritasState{}

class SucessFullFavoritasState extends FavoritasState{
  List<Book> booksFavorites;
  SucessFullFavoritasState({required this.booksFavorites});
}

class ErrorFavoritasState extends FavoritasState{
  String mensagem;
  ErrorFavoritasState({required this.mensagem});
}