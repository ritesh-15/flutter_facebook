import 'dart:convert';

class SearchUser {
  String? id;
  String? avatar;
  String? firstName;
  String? lastName;

  SearchUser({this.id, this.avatar, this.firstName, this.lastName});

  @override
  String toString() {
    return 'User(id: $id, avatar: $avatar, firstName: $firstName, lastName: $lastName)';
  }

  factory SearchUser.fromMap(Map<String, dynamic> data) => SearchUser(
        id: data['id'] as String?,
        avatar: data['avatar'] as dynamic,
        firstName: data['firstName'] as dynamic,
        lastName: data['lastName'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'avatar': avatar,
        'firstName': firstName,
        'lastName': lastName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SearchUser].
  factory SearchUser.fromJson(String data) {
    return SearchUser.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SearchUser] to a JSON string.
  String toJson() => json.encode(toMap());
}
