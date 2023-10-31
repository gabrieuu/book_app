import 'dart:async';

import 'package:book_app/data/bloc/favoritas_bloc/favoritas_event.dart';
import 'package:book_app/data/bloc/favoritas_bloc/favoritas_state.dart';
import 'package:book_app/data/controller/favoritas_controller.dart';
import 'package:book_app/data/model/book_model.dart';

class FavoritasBloc{
  final _controller = FavoritasController();
  final _inputStreamController = StreamController<FavoritasEvent>();
  final _outputStreamController = StreamController<FavoritasState>();

  Sink<FavoritasEvent> get inputEvent => _inputStreamController.sink;
  Stream<FavoritasState> get stream => _outputStreamController.stream;

  FavoritasBloc(){
    _inputStreamController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(FavoritasEvent event) async{
    List<Book> booksFavorites = [];

    _outputStreamController.add(LoadingFavoritasState());
    if(event is GetAllFavoritas){
      booksFavorites = await _controller.getBooksFavorites();
    }
    if(event is AddBookFavorite){
      await _controller.AddBookFavorite(event.idBook);
    }

    _outputStreamController.add(SucessFullFavoritasState(booksFavorites: booksFavorites));
  }
}