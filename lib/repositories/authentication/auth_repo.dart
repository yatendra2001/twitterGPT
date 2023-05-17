import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twitter_gpt/config/paths.dart';
import 'package:twitter_gpt/repositories/authentication/base_auth_repo.dart';
import 'package:twitter_gpt/models/user_model.dart' as user_model;

import 'package:twitter_login/twitter_login.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _firebaseAuth;
  final usersRef = FirebaseFirestore.instance.collection('users');

  AuthRepository({
    FirebaseFirestore? firebaseFirestore,
    auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<bool> checkUserDataExists({required String userId}) async {
    String errorMessage = 'Something went wrong';
    try {
      final user = await usersRef.doc(userId).get();
      return user.exists;
    } catch (e) {
      errorMessage = e.toString();
      debugPrint(e.toString());
    }
    throw Exception(errorMessage);
  }

  @override
  Future<void> updateData(
      {required Map<String, String> json,
      required String uid,
      required bool check}) async {
    check
        ? _firebaseFirestore.collection(Paths.users).doc(uid).update(json)
        : _firebaseFirestore.collection(Paths.users).doc(uid).set(json);
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<user_model.User?> loginUsingTwitter() async {
    try {
      // TWITTER Login
      final twitterLogin = TwitterLogin(
          apiKey: dotenv.get('API_KEY'),
          apiSecretKey: dotenv.get('API_SECRET_KEY'),
          redirectURI: 'twitterGPTAuth://');

      // Trigger the sign-in flow
      final authResult = await twitterLogin.login();
      authResult.status == TwitterLoginStatus.loggedIn
          ? log("twitter login success")
          : log("twitter login failed");

      log("accessToken: ${authResult.authToken}");
      log("authTokenSecret: ${authResult.authTokenSecret}");

      // Create a credential from the access token
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      _firebaseAuth.signInWithCredential(twitterAuthCredential);
      final userDetails = authResult.user;
      final user = user_model.User(
        twitterId: userDetails!.id,
        name: userDetails.name,
        screenName: userDetails.screenName,
        thumbnailImage: userDetails.thumbnailImage,
      );

      return user;
    } catch (error) {
      log("twitter auth error: $error");
    }
    return null;
  }
}
