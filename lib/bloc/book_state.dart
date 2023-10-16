import 'package:book_app/model/book.dart';

abstract class BookState{}

class InitialStateBook extends BookState{}

class LoadingStateBook extends BookState{}

class SucessStateBook extends BookState{
  List<Book> books;
  SucessStateBook(this.books);
}