class User {
  late String? id;
  late String? email;
  late String? active;
  late String? name;
  late String? notifications;
  late String? profilePhoto;
  late String? authKey;
  late String? favoriteId;

  User(
      {
        required this.id,
        required this.email,
        required this.active,
        required this.name,
        required this.notifications,
        required this.profilePhoto,
        required this.authKey,
        required this.favoriteId
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    active = json['active'];
    name = json['name'];
    notifications = json['notifications'];
    profilePhoto = json['profile_photo'];
    authKey = json['auth_key'];
    favoriteId = json['Favorite_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['active'] = active;
    data['name'] = name;
    data['notifications'] = notifications;
    data['profile_photo'] = profilePhoto;
    data['auth_key'] = authKey;
    data['Favorite_id'] = favoriteId;
    return data;
  }
}