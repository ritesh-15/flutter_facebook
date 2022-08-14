import 'dart:convert';

class Otp {
  String? hash;
  String? email;

  Otp({this.hash, this.email});

  factory Otp.fromMap(Map<String, dynamic> data) => Otp(
        hash: data['hash'] as String?,
        email: data['email'] as String?,
      );

  @override
  String toString() {
    return 'Otp(hash:$hash,email:$email)';
  }

  Map<String, dynamic> toMap() => {
        'hash': hash,
        'email': email,
      };

  factory Otp.fromJson(String data) {
    return Otp.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
