class Images{
  String id;
  String url;

  Images({required this.id, required this.url});

  factory Images.fromJson(Map<String, dynamic> json){
    return Images(id: json['id'], url: json['url']);
  }

}