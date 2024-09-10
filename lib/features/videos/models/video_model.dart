class VideoModel {
  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fileURL,
    required this.thumbnailURL,
    required this.creatorUid,
    required this.creator,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String fileURL;
  final String thumbnailURL;
  final String creatorUid;
  final String creator;
  final int likes;
  final int comments;
  final int createdAt;

  VideoModel.fromJson({
    required Map<String, dynamic> json,
    required String videoId,
  })  : title = json["title"],
        description = json["description"],
        fileURL = json["fileURL"],
        thumbnailURL = json["thumbnailURL"],
        creatorUid = json["creatorUid"],
        creator = json["creator"],
        likes = json["likes"],
        comments = json["comments"],
        createdAt = json["createdAt"],
        id = videoId;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "fileURL": fileURL,
      "thumbnailURL": thumbnailURL,
      "creatorUid": creatorUid,
      "creator": creator,
      "likes": likes,
      "comments": comments,
      "createdAt": createdAt,
    };
  }
}
