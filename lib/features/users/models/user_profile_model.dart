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
    required this.isOnline,
    required this.lastSeen,
  });

  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String username;
  final String birthday;
  final bool hasAvatar;
  final bool isOnline;
  final int lastSeen;

  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "",
        username = "",
        birthday = "",
        hasAvatar = false,
        isOnline = true,
        lastSeen = DateTime.now().millisecondsSinceEpoch;

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"] as String,
        email = json["email"] as String,
        name = json["name"] as String,
        bio = json["bio"] as String,
        link = json["link"] as String,
        username = json["username"] as String,
        birthday = json["birthday"] as String,
        hasAvatar = json["hasAvatar"] ?? false,
        isOnline = json["isOnline"] ?? true,
        lastSeen = json["lastSeen"] ?? DateTime.now();

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
      "isOnline": isOnline,
      "lastSeen": lastSeen,
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
    bool? isOnline,
    int? lastSeen,
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
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}
