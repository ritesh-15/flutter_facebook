import 'dart:convert';

class ForgotPasswordResponse {
  bool? ok;
  String? message;

  ForgotPasswordResponse({this.ok, this.message});

  @override
  String toString() {
    return 'ForgotPasswordResponse(ok: $ok, message: $message)';
  }

  factory ForgotPasswordResponse.fromMap(Map<String, dynamic> data) =>
      ForgotPasswordResponse(ok: data["ok"], message: data["message"]);

  Map<String, dynamic> toMap() => {"ok": ok, "message": message};

  factory ForgotPasswordResponse.fromJson(String data) {
    return ForgotPasswordResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
