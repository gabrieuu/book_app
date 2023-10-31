abstract class FavoritasEvent {}

class GetAllFavoritas extends FavoritasEvent{}

class AddBookFavorite extends FavoritasEvent{
  String idBook;
  AddBookFavorite({required this.idBook});
}