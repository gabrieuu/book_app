class BookModel {
  String apiId;
  String imagemUrl;
  String title;
  String author;
  String? publisheDate;
  String? publisher;
  double? averageRating;

  BookModel(
      {required this.apiId,
      required this.imagemUrl,
      required this.title,
      required this.author,
      this.publisheDate,
      this.publisher,
      this.averageRating});

  static BookModel fromOpenLibrary(Map<String, dynamic> json) {
    return BookModel(
        apiId: json['key'] ?? '',
        imagemUrl: json['cover_i'] != null
            ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
            : 'https://via.placeholder.com/300x400',
        title: json['title'] ?? '',
        author: json['author_name']?.first ?? '',
        publisheDate: json['first_publish_year']?.toString(),
        );
  }
}
