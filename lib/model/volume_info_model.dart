import 'package:book_app/model/image_links_model.dart';
import 'package:book_app/model/list_price.dart';

class VolumeInfo {
  String title;
  List<dynamic> authors;
  String? publisher;
  String publishedDate;
  String? description;
  int pageCount;
  List<dynamic> categories;
  ImageLinks? imageLinks;
  //String language;

  VolumeInfo({
    required this.title,
    required this.authors,
    this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.categories,
    this.imageLinks,
    //required this.language,
  });

  static VolumeInfo fromMap(Map<dynamic, dynamic> map) {
    return VolumeInfo(
      title: map["title"],
      authors: map["authors"] ?? [],
      publisher: "${map["publisher"]}",
      publishedDate: "${map["publishedDate"]}",
      description: map["description"],
      pageCount: map["pageCount"] ?? 0,
      categories: map["categories"] ?? [],
      imageLinks: ImageLinks.fromMap((map["imageLinks"] ?? {})),
      //language: map["language"],
    );
  }
}
