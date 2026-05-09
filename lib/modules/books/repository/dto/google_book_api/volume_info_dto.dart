import 'package:book_app/modules/books/repository/dto/google_book_api/image_links_dto.dart';

class GoogleBookVolumeInfo {
  String title;
  List<dynamic> authors;
  String? _publisher;
  String publishedDate;
  String? description;
  int pageCount;
  String isbn;
  String language;
  String? printType;
  List<dynamic> categories;
  GoogleBookImageLinks imageLinks;
  double? averageRating;
  //String language;

  GoogleBookVolumeInfo({
    required this.title,
    required this.authors,
    required String? publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.imageLinks,
    this.isbn = "",
    this.language = "pt",
    this.printType = "BOOK",
    this.averageRating,
  }) {
    _publisher = publisher;
  }

  static GoogleBookVolumeInfo fromMap(Map<dynamic, dynamic> map) {
    return GoogleBookVolumeInfo(
      title: map["title"] ?? "",
      authors: map["authors"] ?? [],
      publisher: map["publisher"] ?? "",
      publishedDate: map["publishedDate"] ?? "",
      description: map["description"] ?? "",
      pageCount: map["pageCount"] ?? 0,
      categories: map["categories"] ?? [],
      imageLinks: GoogleBookImageLinks.fromMap(
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
