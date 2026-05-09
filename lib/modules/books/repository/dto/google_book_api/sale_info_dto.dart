import 'package:book_app/modules/books/repository/dto/google_book_api/list_price_dto.dart';

class GoogleBookSaleInfo{
  String country;
  GoogleBookListPrice? listPrice;

  GoogleBookSaleInfo({
    required this.country,
    required this.listPrice,
  });

  static GoogleBookSaleInfo fromMap(Map<dynamic, dynamic> map) {
    return GoogleBookSaleInfo(
      country: map["country"],
      listPrice: (map["listPrice"] != null) ? GoogleBookListPrice.fromJson(map["listPrice"]) : null
    );
  }
}