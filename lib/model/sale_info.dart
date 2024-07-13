import 'package:book_app/model/list_price.dart';

class SaleInfo{
  String country;
  ListPrice? listPrice;

  SaleInfo({
    required this.country,
    required this.listPrice,
  });

  static SaleInfo fromMap(Map<dynamic, dynamic> map) {
    return SaleInfo(
      country: map["country"],
      listPrice: (map["listPrice"] != null) ? ListPrice.fromJson(map["listPrice"]) : null
    );
  }
}