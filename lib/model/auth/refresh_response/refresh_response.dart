import 'dart:convert';

class RefreshResponse {
  bool? ok;
  String? message;
  String? accessToken;
  String? refreshToken;

  RefreshResponse({
    this.ok,
    this.message,
    this.accessToken,
    this.refreshToken,
  });

  @override
  String toString() {
    return 'RefreshResponse(ok: $ok, message: $message, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  factory RefreshResponse.fromMap(Map<String, dynamic> data) => RefreshResponse(
        ok: data['ok'] as bool?,
        message: data['message'] as String?,
        accessToken: data['accessToken'] as String?,
        refreshToken: data['refreshToken'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'ok': ok,
        'message': message,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  factory RefreshResponse.fromJson(String data) {
    return RefreshResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
