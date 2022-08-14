import 'dart:convert';

class LoginRequest {
  String? email;
  String? password;

  LoginRequest({this.email, this.password});

  factory LoginRequest.fromMap(Map<String, dynamic> data) => LoginRequest(
        email: data['email'] as String?,
        password: data['password'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
      };

  factory LoginRequest.fromJson(String data) {
    return LoginRequest.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
