import 'dart:convert';

import 'package:facebook/model/user/user.dart';

class UserResponse {
  bool? ok;
  String? message;
  User? user;

  UserResponse({
    this.ok,
    this.message,
    this.user,
  });

  @override
  String toString() {
    return 'MeResponse(ok: $ok, message: $message, user: $user)';
  }

  factory UserResponse.fromMap(Map<String, dynamic> data) => UserResponse(
        ok: data['ok'] as bool?,
        message: data['message'] as String?,
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'ok': ok,
        'message': message,
        'user': user?.toMap(),
      };

  factory UserResponse.fromJson(String data) {
    return UserResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
