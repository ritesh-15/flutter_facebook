import 'dart:convert';

import 'following.dart';

class Follower {
  Following? following;

  Follower({this.following});

  @override
  String toString() => 'Follower(following: $following)';

  factory Follower.fromMap(Map<String, dynamic> data) => Follower(
        following: data['following'] == null
            ? null
            : Following.fromMap(data['following'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'following': following?.toMap(),
      };

  factory Follower.fromJson(String data) {
    return Follower.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
