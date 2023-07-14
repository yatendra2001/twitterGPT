import 'dart:convert';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twitter_gpt/models/tweet_model.dart';
import 'package:twitter_gpt/models/user_model.dart';
import 'package:twitter_gpt/models/user_preference.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/session_manager.dart';

class AppwriteRepo {
  late Client client;
  late Account account;
  late Databases database;
  late Storage storage;

  final String databaseId = "6489ea336933d937754c";
  final String userCollectionId = "648a092418104075ffbe";
  final String userPreferenceDataCollectionID = "648a2c199299d5c4769a";
  final String tweetCollectionID = "648b93cf7718b139bae5";
  final String storageBucketId = "6489ea5014920431de2b";
  final SessionManager sessionManager = SessionManager();

  AppwriteRepo() {
    client = Client()
      ..setEndpoint("https://cloud.appwrite.io/v1")
      ..setProject(dotenv.get("APPWRITE_PROJECT_ID"))
      ..setSelfSigned(status: true);
    account = Account(client);
    database = Databases(client);
    storage = Storage(client);
  }

  Future<appwrite_models.User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await account.createEmailSession(
        email: email,
        password: password,
      );
      final user = await account.get();
      await sessionManager
          .setData(jsonEncode({"isLoggedIn": true, "uid": user.$id}));
      debugPrint(user.toMap().toString());
      return user;
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
  }

  Future<bool> addUserDataToUserCollection({required User user}) async {
    try {
      await database.createDocument(
          databaseId: databaseId,
          collectionId: userCollectionId,
          documentId: ID.unique(),
          data: user.toMap());
      return true;
    } on AppwriteException catch (e) {
      debugPrint("Appwrite addUserDataToDatabase error: $e");
    }
    return false;
  }

  Future<bool> addUserPreferenceToUserPreferenceDataCollection(
      {required UserPreference userPreference}) async {
    try {
      await database.createDocument(
          databaseId: databaseId,
          collectionId: userPreferenceDataCollectionID,
          documentId: ID.unique(),
          data: userPreference.toMap());
      return true;
    } on AppwriteException catch (e) {
      debugPrint(
          "Appwrite addUserPreferenceToUserPreferenceDataCollection error: $e");
    }
    return false;
  }

  Future<bool> updateUserPreferenceToUserPreferenceDataCollection(
      {required UserPreference userPreference}) async {
    try {
      final documents = await database.listDocuments(
          databaseId: databaseId,
          collectionId: userPreferenceDataCollectionID,
          queries: [Query.equal('uid', SessionHelper.uid)]);
      await database.updateDocument(
          databaseId: databaseId,
          collectionId: userPreferenceDataCollectionID,
          documentId: documents.documents[0].$id,
          data: userPreference.toMap());
      debugPrint("Check 2");
      return true;
    } on AppwriteException catch (e) {
      debugPrint(
          "Appwrite addUserPreferenceToUserPreferenceDataCollection error: $e");
    }
    return false;
  }

  Future<String?> uploadDataToStorageBucket({required InputFile image}) async {
    final appwrite_models.File file = await storage.createFile(
      bucketId: storageBucketId,
      fileId: ID.unique(),
      file: image,
    );

    debugPrint(file.toMap().toString());
    return file.$id;
  }

  Future<bool> addTweetDataToUserCollection({required TweetModel tweet}) async {
    try {
      await database.createDocument(
          databaseId: databaseId,
          collectionId: tweetCollectionID,
          documentId: ID.unique(),
          data: tweet.toMap());
      return true;
    } on AppwriteException catch (e) {
      debugPrint("Appwrite addUserDataToDatabase error: $e");
    }
    return false;
  }

  Future<User?> getUserData({required String uid}) async {
    try {
      final documents = await database.listDocuments(
          databaseId: databaseId,
          collectionId: userCollectionId,
          queries: [Query.equal('uid', uid)]);
      final user = User.fromMap(documents.documents[0].data);
      return user;
    } on AppwriteException catch (e) {
      debugPrint("Appwrite getUserData error: $e");
    }
    return null;
  }

  Future<UserPreference?> getUserPreferenceData({required String uid}) async {
    try {
      final documents = await database.listDocuments(
          databaseId: databaseId,
          collectionId: userPreferenceDataCollectionID,
          queries: [Query.equal('uid', uid)]);
      final userPreference =
          UserPreference.fromMap(documents.documents[0].data);
      return userPreference;
    } on AppwriteException catch (e) {
      debugPrint("Appwrite getUserPreferenceData error: $e");
    }
    return null;
  }

  Future<void> createPasswordRecovery({
    required String email,
    required String url,
  }) async {
    try {
      final user = await account.createRecovery(
        email: email,
        url: url,
      );
      debugPrint("Token $user");
    } catch (error) {
      debugPrint("Create Password Recovery Error: $error");
    }
  }

  Future<void> logout() {
    log("Logging out");

    return Future.wait([
      account.deleteSession(sessionId: 'current'),
      sessionManager.setData(jsonEncode({"isLoggedIn": false, "uid": ""})),
    ]);
  }
}
