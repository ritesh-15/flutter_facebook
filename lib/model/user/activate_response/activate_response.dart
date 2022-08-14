import 'dart:convert';

import '../../user/user.dart';

class ActivateResponse {
  bool? ok;
  String? message;
  User? user;

  ActivateResponse({
    this.ok,
    this.message,
    this.user,
  });

  @override
  String toString() {
    return 'ActivateResponse(ok: $ok, message: $message, user: $user)';
  }

  factory ActivateResponse.fromMap(Map<String, dynamic> data) =>
      ActivateResponse(
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

  factory ActivateResponse.fromJson(String data) {
    return ActivateResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
