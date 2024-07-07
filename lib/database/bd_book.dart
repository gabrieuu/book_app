import 'package:book_app/model/book_model.dart';
import 'package:hive/hive.dart';

class BDBook {
  static BDBook? _instance;
  late Box _bookBox;

  BDBook._(){
    initBox();
  }

  static String box = "book";

  static BDBook get instance {
    _instance ??= BDBook._();
    return _instance!;
  }

  initBox() async {
    _bookBox = await Hive.openBox(box);
  }

  addBook({required String key, required List listBooks}) async {
    await _bookBox.put('listBook', [key, listBooks]);
  }

  List? get getBooks => _bookBox.get('listBook');

  addFavorito(){
    
  }
}