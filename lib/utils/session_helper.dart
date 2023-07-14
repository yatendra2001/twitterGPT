import 'dart:io';

import 'package:twitter_gpt/models/user_model.dart';
import 'package:twitter_gpt/models/user_preference.dart';
import 'package:twitter_gpt/utils/onboarding_data.dart';

class SessionHelper {
  static String? displayName;
  static String? firstName;
  static String? lastName;

  static String? username;
  static String? phone;
  static String? age;
  static String? uid;
  static String? profileImageUrl;
  static String? bearerToken;
  static String? prompt;

  static String? appwriteName;
  static String? appwriteEmail;
  static String? appwritePassword;

  static String? accessToken;
  static String? accessTokenSecret;

  static List<String>? thread;

  static User? user;
  static UserPreference? userPreference;

  static String? tweet;

  static File? currentFile;
  static String? currentImageUrl;

  static bool? isHomePageLoaded = false;
  static bool? isTweetDataLoaded = false;

  static Map<String, List<int>>? userOnboardedData = {
    OnboardingData.topics: [],
    OnboardingData.writingStyle: [],
    OnboardingData.conversationTone: []
  };
}

class SessionHelperEmpty {
  SessionHelperEmpty() {
    SessionHelper.age = null;
    SessionHelper.displayName = null;
    SessionHelper.firstName = null;
    SessionHelper.lastName = null;
    SessionHelper.username = null;
    SessionHelper.phone = null;
    SessionHelper.uid = null;
    SessionHelper.bearerToken = null;
    SessionHelper.profileImageUrl = null;
    SessionHelper.prompt = null;
    SessionHelper.thread = null;
    SessionHelper.currentFile = null;
    SessionHelper.currentImageUrl = null;
    SessionHelper.userOnboardedData = {
      OnboardingData.topics: [],
      OnboardingData.writingStyle: [],
      OnboardingData.conversationTone: []
    };
    SessionHelper.appwriteName = null;
    SessionHelper.appwriteEmail = null;
    SessionHelper.appwritePassword = null;
  }
}
