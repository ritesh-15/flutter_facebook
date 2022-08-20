import 'dart:convert';

import 'search_user.dart';

class SearchUsersResponse {
  bool? ok;
  String? message;
  List<SearchUser>? users;

  SearchUsersResponse({this.ok, this.message, this.users});

  @override
  String toString() {
    return 'SearchUsersResponse(ok: $ok, message: $message, users: $users)';
  }

  factory SearchUsersResponse.fromMap(Map<String, dynamic> data) {
    return SearchUsersResponse(
      ok: data['ok'] as bool?,
      message: data['message'] as String?,
      users: (data['users'] as List<dynamic>?)
          ?.map((e) => SearchUser.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'ok': ok,
        'message': message,
        'users': users?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SearchUsersResponse].
  factory SearchUsersResponse.fromJson(String data) {
    return SearchUsersResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SearchUsersResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
