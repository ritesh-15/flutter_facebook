import 'dart:convert';

class Following {
	String? id;
	String? firstName;
	String? lastName;
	String? avatar;

	Following({this.id, this.firstName, this.lastName, this.avatar});

	@override
	String toString() {
		return 'Following(id: $id, firstName: $firstName, lastName: $lastName, avatar: $avatar)';
	}

	factory Following.fromMap(Map<String, dynamic> data) => Following(
				id: data['id'] as String?,
				firstName: data['firstName'] as String?,
				lastName: data['lastName'] as String?,
				avatar: data['avatar'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'firstName': firstName,
				'lastName': lastName,
				'avatar': avatar,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Following].
	factory Following.fromJson(String data) {
		return Following.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Following] to a JSON string.
	String toJson() => json.encode(toMap());
}
