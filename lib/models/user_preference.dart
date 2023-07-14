// ignore_for_file: public_member_api_docs, sort_constructors_first
// 🎯 Dart imports:
import 'dart:convert';

import 'package:equatable/equatable.dart';

// 🐦 Flutter imports:

class UserPreference extends Equatable {
  final String? uid;
  final List<String>? userTopics;
  final List<String>? userWritingStyle;
  final List<String>? userWritingTone;
  final String userFormattingPreferenceMap;
  const UserPreference({
    this.uid,
    this.userTopics,
    this.userWritingStyle,
    this.userWritingTone,
    required this.userFormattingPreferenceMap,
  });

  UserPreference copyWith({
    String? uid,
    List<String>? userTopics,
    List<String>? userWritingStyle,
    List<String>? userWritingTone,
    String? userFormattingPreferenceMap,
  }) {
    return UserPreference(
      uid: uid ?? this.uid,
      userTopics: userTopics ?? this.userTopics,
      userWritingStyle: userWritingStyle ?? this.userWritingStyle,
      userWritingTone: userWritingTone ?? this.userWritingTone,
      userFormattingPreferenceMap:
          userFormattingPreferenceMap ?? this.userFormattingPreferenceMap,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userTopics': userTopics,
      'userWritingStyle': userWritingStyle,
      'userWritingTone': userWritingTone,
      'userFormattingPreferenceMap': userFormattingPreferenceMap,
    };
  }

  factory UserPreference.fromMap(Map<String, dynamic> map) {
    return UserPreference(
      uid: map['uid'] != null ? map['uid'] as String : null,
      userTopics: map['userTopics'] != null
          ? List<String>.from((map['userTopics']))
          : null,
      userWritingStyle: map['userWritingStyle'] != null
          ? List<String>.from((map['userWritingStyle']))
          : null,
      userWritingTone: map['userWritingTone'] != null
          ? List<String>.from((map['userWritingTone']))
          : null,
      userFormattingPreferenceMap: map['userFormattingPreferenceMap'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPreference.fromJson(String source) =>
      UserPreference.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      uid!,
      userTopics!,
      userWritingStyle!,
      userWritingTone!,
      userFormattingPreferenceMap,
    ];
  }
}
