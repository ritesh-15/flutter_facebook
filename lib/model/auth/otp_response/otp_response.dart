import 'dart:convert';

import 'otp.dart';

class OtpResponse {
  bool? ok;
  String? message;
  Otp? otp;

  OtpResponse({this.ok, this.message, this.otp});

  factory OtpResponse.fromMap(Map<String, dynamic> data) {
    return OtpResponse(
      ok: data['ok'] as bool?,
      message: data['message'] as String?,
      otp: data['otp'] == null
          ? null
          : Otp.fromMap(data['otp'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'RegisterResponse(ok: $ok, message: $message, Otp:${otp.toString()})';
  }

  Map<String, dynamic> toMap() => {
        'ok': ok,
        'message': message,
        'otp': otp?.toMap(),
      };

  factory OtpResponse.fromJson(String data) {
    return OtpResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
