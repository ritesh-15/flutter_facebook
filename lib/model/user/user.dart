import 'dart:convert';

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;
  String? cover;
  String? bio;
  bool? isVerified;
  bool? isActivated;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
    this.cover,
    this.bio,
    this.isVerified,
    this.isActivated,
  });

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, avatar: $avatar, cover: $cover, bio: $bio, isVerified: $isVerified, isActivated: $isActivated)';
  }

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as String?,
        firstName: data['firstName'] as String?,
        lastName: data['lastName'] as String?,
        email: data['email'] as String?,
        avatar: data['avatar'] as String?,
        cover: data['cover'] as String?,
        bio: data['bio'] as String?,
        isVerified: data['isVerified'] as bool?,
        isActivated: data['isActivated'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'avatar': avatar,
        'cover': cover,
        'bio': bio,
        'isVerified': isVerified,
        'isActivated': isActivated,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
