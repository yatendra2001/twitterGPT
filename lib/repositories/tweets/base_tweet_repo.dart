import 'package:twitter_api_v2/twitter_api_v2.dart';
import 'package:twitter_gpt/models/user_model.dart';

abstract class BaseTweetRepo {
  Future<User?> getTwitterUserProfile();
  Future<String?> generateTweet();
  Future<List<String>?> generateThread({required String userProfile});
  Future<void> postTweet(
      {required String tweetText, required String tweetMediaID});
  Future<List<TweetData>> postThread({required List<String> thread});
}
