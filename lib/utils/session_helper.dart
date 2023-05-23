import 'dart:io';

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

  static List<String>? thread;

  static File? currentFile;
  static String? currentImageUrl;
  static List<String>? currentToxicChemicalsList;

  static bool isThroughHistory = false;
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
  }
}
