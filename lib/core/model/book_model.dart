

import 'package:book_app/core/model/volume_info_model.dart';

class Book {
  String id;
  String etag;
  VolumeInfo volumeInfo;
  bool isFavorite = false;

  Book({
    required this.id,
    required this.etag,
    required this.volumeInfo,
  });

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map["id"],
      etag: map["etag"],
      volumeInfo: VolumeInfo.fromMap(map["volumeInfo"])
    );
  }
}
