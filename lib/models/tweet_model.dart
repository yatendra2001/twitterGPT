// ignore_for_file: public_member_api_docs, sort_constructors_first
// 🎯 Dart imports:
import 'dart:convert';

import 'package:equatable/equatable.dart';

// 🐦 Flutter imports:

class TweetModel extends Equatable {
  final String? uid;
  final String? prompt;
  final String? text;
  final String? fileId;
  const TweetModel({
    this.uid,
    this.prompt,
    this.text,
    this.fileId,
  });

  TweetModel copyWith({
    String? uid,
    String? prompt,
    String? text,
    String? fileId,
  }) {
    return TweetModel(
      uid: uid ?? this.uid,
      prompt: prompt ?? this.prompt,
      text: text ?? this.text,
      fileId: fileId ?? this.fileId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'prompt': prompt,
      'text': text,
      'fileId': fileId,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      prompt: map['prompt'] != null ? map['prompt'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      fileId: map['fileId'] != null ? map['fileId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModel.fromJson(String source) =>
      TweetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [uid!, prompt!, text!, fileId!];
}
