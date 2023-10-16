import 'dart:async';

import 'package:book_app/bloc/book_event.dart';
import 'package:book_app/bloc/book_state.dart';
import 'package:book_app/model/book.dart';
import 'package:book_app/repository/book_repository.dart';

class BookBloc {
  final _repository = BookRepository();
  final StreamController<BookEvent> _inputStreamController = StreamController();
  final StreamController<BookState> _outputStreamController = StreamController();

  Sink<BookEvent> get input => _inputStreamController.sink;
  Stream<BookState> get stream => _outputStreamController.stream;

  BookBloc(){
    _inputStreamController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(BookEvent event) async{
    List<Book> books = [];
    _outputStreamController.add(LoadingStateBook());
    if(event is GetBooks){
      books = await _repository.fetchAllBooks(event.book);
    }
    books.map((e) => print(e.volumeInfo.title)).toList();
    if(books.isNotEmpty) _outputStreamController.add(SucessStateBook(books));
  }


  void dispose(){
    _inputStreamController.close();
  }
}