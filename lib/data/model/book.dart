

import 'package:book_app/data/model/volume_info.dart';

class Book {
  String id;
  String etag;
  VolumeInfo volumeInfo;

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
