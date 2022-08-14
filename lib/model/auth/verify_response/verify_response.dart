import 'dart:convert';

import '../../user/user.dart';

class VerifyOtpResponse {
  bool? ok;
  String? message;
  User? user;
  String? accessToken;
  String? refreshToken;

  VerifyOtpResponse({
    this.ok,
    this.message,
    this.user,
    this.accessToken,
    this.refreshToken,
  });

  @override
  String toString() {
    return 'VerifyOtpResponse(ok: $ok, message: $message, user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  factory VerifyOtpResponse.fromMap(Map<String, dynamic> data) =>
      VerifyOtpResponse(
        ok: data['ok'] as bool?,
        message: data['message'] as String?,
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        accessToken: data['accessToken'] as String?,
        refreshToken: data['refreshToken'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'ok': ok,
        'message': message,
        'user': user?.toMap(),
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  factory VerifyOtpResponse.fromJson(String data) {
    return VerifyOtpResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
