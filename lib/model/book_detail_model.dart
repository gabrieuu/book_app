class BookDetailModel {
  final String title;
  final String description;
  final List<String> coversUrls;
  final String? authorId;
  final String publisheDate;
  final String? publisher;
  final double? averageRating;

  BookDetailModel({
    required this.title,
    required this.description,
    required this.coversUrls,
    required this.authorId,
    required this.publisheDate,
    this.publisher,
    this.averageRating
  });
  
  factory BookDetailModel.fromOpenLibrary(Map<String, dynamic> json) {
    return BookDetailModel(
      title: json['title'] ?? 'Título desconhecido',
      description: json['description'] is String
          ? json['description']
          : (json['description']?['value'] ?? 'Sem descrição disponível'),
      coversUrls: (json['covers'] as List<dynamic>?)
              ?.map((coverId) =>
                  'https://covers.openlibrary.org/b/id/$coverId-L.jpg')
              .toList() ??
          [],
      authorId: (json['authors'] != null && (json['authors'] as List).isNotEmpty)
          ? json['authors'][0]['author']['key']?.toString().replaceFirst('/authors/', '')
          : null,
      publisheDate: json['created']?['value'] ?? 'Data de publicação desconhecida',
    );
    }

}