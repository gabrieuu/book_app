import 'package:book_app/model/book_model.dart';
import 'package:book_app/core/status.dart';
import 'package:book_app/modules/books/repository/book_repository.dart';
import 'package:book_app/modules/books/store/book_store.dart';
import 'package:book_app/modules/favoritas/repository/favorite_repository.dart';
import 'package:mobx/mobx.dart';
part 'favoritas_store.g.dart';

class FavoritasStore = _FavoritasStoreBase with _$FavoritasStore;

abstract class _FavoritasStoreBase with Store {
  //final bookRepository = Modular.get<BookRepository>();
  final FavoritaRepository favoritesRepository;

  final BookRepository bookRepository;

  @observable
  Status favoritasLoading = Status.NAO_CARREGADO;

  @observable
  ObservableList<Book> listBooksFavorites = ObservableList.of([]);

  _FavoritasStoreBase(this.bookRepository,this.favoritesRepository){
    _init();
  }

  _init() async{
    await getBooksFavorites();
  }

  @action
  Future<void> addFavorite(Book book) async{
    listBooksFavorites.add(book);
    await favoritesRepository.addFavorite(book.id);
  }

  @action
  Future<void> getBooksFavorites() async{ 
    List<String> lists = await favoritesRepository.booksFavorites();
    listBooksFavorites = ObservableList.of(await bookRepository.fetchFavoritesBooks(lists));
  }

  @action
  bool isFavorita(Book book){
    for(int i = 0; i < listBooksFavorites.length; i++){
      if(listBooksFavorites[i].id == book.id) return true;
    }
    return false;
  }

  @action
  removeFavorita(Book book) async{  
    listBooksFavorites.removeWhere((element) => element.id == book.id);
    await favoritesRepository.removeFavorita(book.id);
  }

}