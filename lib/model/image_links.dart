class ImageLinks{
  String? smallThumb;
	String? thumbnail;

  ImageLinks({
     this.smallThumb,
     this.thumbnail
  });

  static ImageLinks fromMap(Map<String, dynamic> map){
    return ImageLinks(
      smallThumb: map["smallThumbnail"],
      thumbnail: map["thumbnail"]
    );
  }

}