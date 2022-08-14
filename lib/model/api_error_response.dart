import 'dart:convert';

class ApiErrorResponse {
  bool? ok;
  String? message;
  int? code;
  String? error;

  ApiErrorResponse({this.ok, this.message, this.code, this.error});

  factory ApiErrorResponse.fromMap(Map<String, dynamic> data) {
    return ApiErrorResponse(
      ok: data['ok'] as bool?,
      message: data['message'] as String?,
      code: data['code'] as int?,
      error: data['error'] as String?,
    );
  }

  @override
  String toString() {
    return "ApiErrorResponse(ok:$ok, message:$message, code:$code, error:$error)";
  }

  Map<String, dynamic> toMap() => {
        'ok': ok,
        'message': message,
        'code': code,
        'error': error,
      };

  factory ApiErrorResponse.fromJson(String data) {
    return ApiErrorResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
