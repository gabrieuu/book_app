class BookPostModel {
  final String bookId;
  final String title;
  final String author;
  final String imageUrl;
  final int pageQuantity;
  final int pageRead;
  final double rating;

  BookPostModel({
    required this.bookId,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.pageQuantity,
    required this.pageRead,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'pageQuantity': pageQuantity,
      'pageRead': pageRead,
      'rating': rating,
    };
  }

  factory BookPostModel.fromJson(Map<String, dynamic> json) {
    return BookPostModel(
      bookId: json['bookId'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      imageUrl: json['imageUrl'] as String,
      pageQuantity: json['pageQuantity'] as int,
      pageRead: json['pageRead'] as int,
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
