import 'package:twitter_api_v2/twitter_api_v2.dart';

abstract class BaseTweetRepo {
  Future<String?> getUsername();
  Future<String?> generateTweet({required String userProfile});
  Future<List<String>?> generateThread({required String userProfile});
  Future<void> postTweet({required String tweetText});
  Future<List<TweetData>> postThread({required List<String> thread});
}
