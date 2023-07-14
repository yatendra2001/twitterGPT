// ignore_for_file: public_member_api_docs, sort_constructors_first
// 🎯 Dart imports:
import 'dart:convert';

import 'package:equatable/equatable.dart';

// 🐦 Flutter imports:

class User extends Equatable {
  final String? uid;
  final String? accessToken;
  final String? accessTokenSecret;
  final String? name;
  final String? username;
  final String? profileImageUrl;
  final String? email;
  const User({
    this.uid,
    this.accessToken,
    this.accessTokenSecret,
    this.name,
    this.username,
    this.profileImageUrl,
    this.email,
  });

  User copyWith({
    String? uid,
    String? accessToken,
    String? accessTokenSecret,
    String? name,
    String? username,
    String? profileImageUrl,
    String? email,
  }) {
    return User(
      uid: uid ?? this.uid,
      accessToken: accessToken ?? this.accessToken,
      accessTokenSecret: accessTokenSecret ?? this.accessTokenSecret,
      name: name ?? this.name,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'accessToken': accessToken,
      'accessTokenSecret': accessTokenSecret,
      'name': name,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] != null ? map['uid'] as String : null,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      accessTokenSecret: map['accessTokenSecret'] != null
          ? map['accessTokenSecret'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      profileImageUrl: map['profileImageUrl'] != null
          ? map['profileImageUrl'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      uid!,
      accessToken!,
      accessTokenSecret!,
      name!,
      username!,
      profileImageUrl!,
      email!,
    ];
  }
}
