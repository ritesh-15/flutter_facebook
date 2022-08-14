import 'dart:convert';

class User {
	String? id;
	String? firstName;
	String? lastName;
	String? email;
	dynamic avatar;
	dynamic cover;
	dynamic bio;
	bool? isVerified;
	bool? isActivated;
	dynamic password;

	User({
		this.id, 
		this.firstName, 
		this.lastName, 
		this.email, 
		this.avatar, 
		this.cover, 
		this.bio, 
		this.isVerified, 
		this.isActivated, 
		this.password, 
	});

	@override
	String toString() {
		return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, avatar: $avatar, cover: $cover, bio: $bio, isVerified: $isVerified, isActivated: $isActivated, password: $password)';
	}

	factory User.fromMap(Map<String, dynamic> data) => User(
				id: data['id'] as String?,
				firstName: data['firstName'] as String?,
				lastName: data['lastName'] as String?,
				email: data['email'] as String?,
				avatar: data['avatar'] as dynamic,
				cover: data['cover'] as dynamic,
				bio: data['bio'] as dynamic,
				isVerified: data['isVerified'] as bool?,
				isActivated: data['isActivated'] as bool?,
				password: data['password'] as dynamic,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'firstName': firstName,
				'lastName': lastName,
				'email': email,
				'avatar': avatar,
				'cover': cover,
				'bio': bio,
				'isVerified': isVerified,
				'isActivated': isActivated,
				'password': password,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
	factory User.fromJson(String data) {
		return User.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
	String toJson() => json.encode(toMap());
}
