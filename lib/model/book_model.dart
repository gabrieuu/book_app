import 'package:book_app/model/sale_info.dart';
import 'package:book_app/model/volume_info_model.dart';

class Book {
  String id;
  String etag;
  VolumeInfo volumeInfo;
  SaleInfo saleInfo;
  bool isFavorite = false;

  Book(
      {required this.id,
      required this.etag,
      required this.volumeInfo,
      required this.saleInfo});

  static Book fromMap(Map<dynamic, dynamic> map) {
    return Book(
        id: map["id"],
        etag: map["etag"],
        volumeInfo: VolumeInfo.fromMap(map["volumeInfo"]),
        saleInfo: SaleInfo.fromMap(map["saleInfo"]));
  }
}
