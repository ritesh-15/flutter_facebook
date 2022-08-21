import 'dart:convert';

class FollowUnFollowResponse {
	bool? ok;
	String? message;

	FollowUnFollowResponse({this.ok, this.message});

	factory FollowUnFollowResponse.fromMap(Map<String, dynamic> data) {
		return FollowUnFollowResponse(
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
  /// Parses the string and returns the resulting Json object as [FollowUnFollowResponse].
	factory FollowUnFollowResponse.fromJson(String data) {
		return FollowUnFollowResponse.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [FollowUnFollowResponse] to a JSON string.
	String toJson() => json.encode(toMap());
}
