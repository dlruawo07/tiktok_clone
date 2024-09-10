class UserProfileModel {
  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
    required this.username,
    required this.birthday,
    required this.hasAvatar,
  });

  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String username;
  final String birthday;
  final bool hasAvatar;

  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "",
        username = "",
        birthday = "",
        hasAvatar = false;

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"] as String,
        email = json["email"] as String,
        name = json["name"] as String,
        bio = json["bio"] as String,
        link = json["link"] as String,
        username = json["username"] as String,
        birthday = json["birthday"] as String,
        hasAvatar = json["hasAvatar"] ?? false;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
      "username": username,
      "birthday": birthday,
      "hasAvatar": hasAvatar,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    String? username,
    String? birthday,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      username: username ?? this.username,
      birthday: birthday ?? this.birthday,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
