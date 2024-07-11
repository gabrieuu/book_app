import 'package:hive/hive.dart';

class BDBook {
   Box bookBox = Hive.box(box);

  static String box = "book";


  Future<void> addBook({required String key, required List<dynamic> listBooks}) async {
    await bookBox.put('listBook', [key, listBooks]);
  }

  List<dynamic>? getBooks() {
    return bookBox.get('listBook');
  }

  Future<void> addFavorito(String bookKey) async {// Garante que _bookBox seja inicializado antes de usar
    List<dynamic>? books = getBooks();
    if (books != null) {
      books.add(bookKey);
      await bookBox.put('listBook', books);
    }
  }
}