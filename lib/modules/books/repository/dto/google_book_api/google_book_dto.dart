import 'package:book_app/modules/books/repository/dto/google_book_api/sale_info_dto.dart';
import 'package:book_app/modules/books/repository/dto/google_book_api/volume_info_dto.dart';

class GoogleBookDTO {
  String id;
  String etag;
  GoogleBookVolumeInfo volumeInfo;
  GoogleBookSaleInfo saleInfo;
  bool isFavorite = false;

  GoogleBookDTO(
      {required this.id,
      required this.etag,
      required this.volumeInfo,
      required this.saleInfo});

  static GoogleBookDTO fromMap(Map<dynamic, dynamic> map) {
    return GoogleBookDTO(
        id: map["id"],
        etag: map["etag"],
        volumeInfo: GoogleBookVolumeInfo.fromMap(map["volumeInfo"]),
        saleInfo: GoogleBookSaleInfo.fromMap(map["saleInfo"]));
  }
}