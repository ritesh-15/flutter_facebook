import 'dart:convert';

import 'follower.dart';
import 'following.dart';

class ProfileUserData {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic avatar;
  dynamic cover;
  dynamic bio;
  bool? isVerified;
  bool? isActivated;
  List<Follower>? followers;
  List<Following>? followings;
  bool? isFollowedByMe;

  ProfileUserData(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.avatar,
      this.cover,
      this.bio,
      this.isVerified,
      this.isActivated,
      this.followers,
      this.followings,
      this.isFollowedByMe});

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, avatar: $avatar, cover: $cover, bio: $bio, isVerified: $isVerified, isActivated: $isActivated, followers: $followers, followings: $followings, isFollowedByMe:$isFollowedByMe)';
  }

  factory ProfileUserData.fromMap(Map<String, dynamic> data) => ProfileUserData(
      id: data['id'] as String?,
      firstName: data['firstName'] as String?,
      lastName: data['lastName'] as String?,
      email: data['email'] as String?,
      avatar: data['avatar'] as dynamic,
      cover: data['cover'] as dynamic,
      bio: data['bio'] as dynamic,
      isVerified: data['isVerified'] as bool?,
      isActivated: data['isActivated'] as bool?,
      followers: (data['followers'] as List<dynamic>?)
          ?.map((e) => Follower.fromMap(e as Map<String, dynamic>))
          .toList(),
      followings: (data['followings'] as List<dynamic>?)
          ?.map((e) => Following.fromMap(e as Map<String, dynamic>))
          .toList(),
      isFollowedByMe: data['isFollowedByMe'] as bool?);

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
        'followers': followers?.map((e) => e.toMap()).toList(),
        'followings': followings?.map((e) => e.toMap()).toList(),
        "isFollowedByMe": isFollowedByMe
      };

  factory ProfileUserData.fromJson(String data) {
    return ProfileUserData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
