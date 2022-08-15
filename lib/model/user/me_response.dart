import 'dart:convert';

import 'package:facebook/model/user/user.dart';

class MeResponse {
  bool? ok;
  String? message;
  User? user;

  MeResponse({
    this.ok,
    this.message,
    this.user,
  });

  @override
  String toString() {
    return 'MeResponse(ok: $ok, message: $message, user: $user)';
  }

  factory MeResponse.fromMap(Map<String, dynamic> data) => MeResponse(
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

  factory MeResponse.fromJson(String data) {
    return MeResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
