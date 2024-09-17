class UserResponse {
  final bool? success;
  final User? user;
  dynamic version;

  UserResponse({
    this.success,
    this.user,
    this.version,
  });

  UserResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        version = json['version'],
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'success': success, 'user': user?.toJson()};
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? imageUrl;

  User({this.id, this.name, this.email, this.imageUrl});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        imageUrl = json['image_path'] as String?;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image_path": imageUrl,
      };
}
