import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:twitter_gpt/models/user_model.dart' as user_model;

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;
  Future<user_model.User?> loginUsingTwitter();

  Future<bool> checkUserDataExists({required String userId});

  Future<void> updateData(
      {required Map<String, String> json,
      required String uid,
      required bool check});

  Future<void> logOut();
}
