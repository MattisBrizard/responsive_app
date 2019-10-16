import 'dart:convert';

class RandomImage {
  RandomImage({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  factory RandomImage.fromJson(String str) =>
      RandomImage.fromMap(json.decode(str));

  factory RandomImage.fromMap(Map<String, dynamic> json) => RandomImage(
        id: json['id'],
        author: json['author'],
        width: json['width'],
        height: json['height'],
        url: json['url'],
        downloadUrl: json['download_url'],
      );
  String id;
  String author;
  int width;
  int height;
  String url;
  String downloadUrl;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'author': author,
        'width': width,
        'height': height,
        'url': url,
        'download_url': downloadUrl,
      };
}
