class GoogleBookImageLinks {
  late String _smallThumb;
  late String _thumbnail;

  GoogleBookImageLinks({required String smallThumb, required String thumbnail}) {
    _smallThumb = smallThumb;
    _thumbnail = thumbnail;
  }

  static GoogleBookImageLinks fromMap(Map<dynamic, dynamic> map) {
    return GoogleBookImageLinks(
      smallThumb: map["smallThumbnail"] ?? "",
      thumbnail: map["thumbnail"] ?? "",
    );
  }

  String get smallThumb {
    String small = _smallThumb;
    if (_smallThumb == "") {
      small = _thumbnail;
    }
    return small;
  }

  String get thumbnail {
    String thumb = _thumbnail;
    if (_thumbnail == "") {
      thumb = _smallThumb;
    }
    return thumb;
  }
}
