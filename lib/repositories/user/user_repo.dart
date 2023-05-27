// 🎯 Dart imports:
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_gpt/config/paths.dart';
import 'package:twitter_gpt/repositories/user/base_user_repo.dart';

// 🌎 Project imports:
import '../../models/user_model.dart';

class UserRepo extends BaseUserRepo {
  CollectionReference users =
      FirebaseFirestore.instance.collection(Paths.users);

  @override
  Future<void> addData({required User user}) async {
    try {
      await users.add(User(
        twitterId: user.twitterId,
        name: user.name,
        screenName: user.screenName,
        thumbnailImage: user.thumbnailImage,
      ).toMap());
    } catch (error) {
      log("user repo addData error: $error");
    }
  }
}
