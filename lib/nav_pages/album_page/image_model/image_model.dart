class ImageModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  ImageModel(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  ImageModel.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
