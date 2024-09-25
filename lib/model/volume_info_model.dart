import 'package:book_app/model/image_links_model.dart';
import 'package:book_app/model/list_price.dart';

class VolumeInfo {
  String title;
  List<dynamic> authors;
  String? _publisher;
  String publishedDate;
  String? description;
  int pageCount;
  List<dynamic> categories;
  ImageLinks imageLinks;
  double? averageRating;
  //String language;

  VolumeInfo({
    required this.title,
    required this.authors,
    required String? publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.imageLinks,
    this.averageRating,
  }) {
    _publisher = publisher;
  }

  static VolumeInfo fromMap(Map<dynamic, dynamic> map) {
    return VolumeInfo(
      title: map["title"] ?? "",
      authors: map["authors"] ?? [],
      publisher: map["publisher"] ?? "",
      publishedDate: map["publishedDate"] ?? "",
      description: map["description"] ?? "",
      pageCount: map["pageCount"] ?? 0,
      categories: map["categories"] ?? [],
      imageLinks: ImageLinks.fromMap(
          map["imageLinks"] ?? {"smallThumbnail": "", "thumbnail": ""}),
      //language: map["language"],
    );
  }

  bool contemDadoNull() {
    return title == "" ||
        authors.isEmpty ||
        publisher == "" ||
        publishedDate == "" ||
        description == "" ||
        pageCount == 0 ||
        categories.isEmpty ||
        (imageLinks.smallThumb == "" && imageLinks.thumbnail == "");
  }

  set publisher(String publisher) {
    _publisher = publisher;
  }

  String get publisher {
    return _publisher?.split('Editora ').last ?? '';
  }
}
