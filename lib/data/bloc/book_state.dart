
import 'package:book_app/data/model/book.dart';

abstract class BookState{}

class InitialStateBook extends BookState{}

class LoadingStateBook extends BookState{}

class SucessStateBook extends BookState{
  List<Book> books;
  SucessStateBook(this.books);
}

class ErrorStateBook extends BookState{
  String mensagem;
  ErrorStateBook({required this.mensagem});
}