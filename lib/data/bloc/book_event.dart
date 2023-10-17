abstract class BookEvent{}

class GetBooks extends BookEvent{
  String book;
  GetBooks({required this.book});
}