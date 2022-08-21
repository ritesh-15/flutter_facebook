import 'dart:convert';

import 'ProfileUserData.dart';

class ProfileResponse {
  bool? ok;
  ProfileUserData? user;

  ProfileResponse({this.ok, this.user});

  @override
  String toString() => 'ProfileResponse(ok: $ok, user: $user)';

  factory ProfileResponse.fromMap(Map<String, dynamic> data) {
    return ProfileResponse(
      ok: data['ok'] as bool?,
      user: data['user'] == null
          ? null
          : ProfileUserData.fromMap(data['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'ok': ok,
        'user': user?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProfileResponse].
  factory ProfileResponse.fromJson(String data) {
    return ProfileResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProfileResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
