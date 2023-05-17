// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? uid;
  final int? twitterId;
  final String? name;
  final String? screenName;
  final String? thumbnailImage;
  const User({
    this.uid,
    this.twitterId,
    this.name,
    this.screenName,
    this.thumbnailImage,
  });

  User copyWith({
    String? uid,
    int? twitterId,
    String? name,
    String? screenName,
    String? thumbnailImage,
  }) {
    return User(
      uid: uid ?? this.uid,
      twitterId: twitterId ?? this.twitterId,
      name: name ?? this.name,
      screenName: screenName ?? this.screenName,
      thumbnailImage: thumbnailImage ?? this.thumbnailImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'twitterId': twitterId,
      'name': name,
      'screenName': screenName,
      'thumbnailImage': thumbnailImage,
    };
  }

  factory User.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      twitterId: map['twitterId'] != null ? map['twitterId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      screenName:
          map['screenName'] != null ? map['screenName'] as String : null,
      thumbnailImage: map['thumbnailImage'] != null
          ? map['thumbnailImage'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      uid!,
      twitterId!,
      name!,
      screenName!,
      thumbnailImage!,
    ];
  }
}
