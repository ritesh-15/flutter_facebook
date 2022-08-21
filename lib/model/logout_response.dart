import 'dart:convert';

class LogoutResponse {
	bool? ok;
	String? message;

	LogoutResponse({this.ok, this.message});

	factory LogoutResponse.fromMap(Map<String, dynamic> data) {
		return LogoutResponse(
			ok: data['ok'] as bool?,
			message: data['message'] as String?,
		);
	}



	Map<String, dynamic> toMap() => {
				'ok': ok,
				'message': message,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LogoutResponse].
	factory LogoutResponse.fromJson(String data) {
		return LogoutResponse.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [LogoutResponse] to a JSON string.
	String toJson() => json.encode(toMap());
}
