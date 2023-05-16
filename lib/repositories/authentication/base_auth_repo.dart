import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;
  Future<void> loginUsingTwitter();

  Future<bool> checkUserDataExists({required String userId});

  Future<void> updateData(
      {required Map<String, String> json,
      required String uid,
      required bool check});

  Future<void> logOut();
}
