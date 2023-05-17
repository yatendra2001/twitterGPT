import 'dart:async';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twitter_gpt/repositories/tweets/base_tweet_repo.dart';
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;
import 'package:twitter_gpt/repositories/user/user_repo.dart';

class TweetRepo extends BaseTweetRepo {
  final v2.TwitterApi _twitter;
  TweetRepo({v2.TwitterApi? twitter, UserRepo? userRepo})
      : _twitter = twitter ??
            v2.TwitterApi(
              bearerToken: '',
              oauthTokens: v2.OAuthTokens(
                consumerKey: dotenv.get('API_KEY'),
                consumerSecret: dotenv.get('API_SECRET_KEY'),
                accessToken: dotenv.get('ACCESS_TOKEN'),
                accessTokenSecret: dotenv.get('ACCESS_TOKEN_SECRET'),
              ),
            );
  @override
  Future<void> getAllTweets() async {
    try {
      final me = await _twitter.users.lookupMe(
        userFields: const [
          v2.UserField.id,
          v2.UserField.name,
          v2.UserField.username,
          v2.UserField.description,
          v2.UserField.entities,
          v2.UserField.profileImageUrl,
          v2.UserField.location,
          v2.UserField.protected,
          v2.UserField.verified,
          v2.UserField.verifiedType,
          v2.UserField.publicMetrics,
          v2.UserField.createdAt,
          v2.UserField.withheld,
        ],
        expansions: [
          v2.UserExpansion.pinnedTweetId,
        ],
        tweetFields: const [
          v2.TweetField.attachments,
          v2.TweetField.authorId,
          v2.TweetField.contextAnnotations,
          v2.TweetField.conversationId,
          v2.TweetField.createdAt,
          v2.TweetField.entities,
          v2.TweetField.geo,
          v2.TweetField.id,
          v2.TweetField.inReplyToUserId,
          v2.TweetField.lang,
          v2.TweetField.privateMetrics,
          v2.TweetField.organicMetrics,
          v2.TweetField.promotedMetrics,
          v2.TweetField.publicMetrics,
          v2.TweetField.possiblySensitive,
          v2.TweetField.referencedTweets,
          v2.TweetField.replySettings,
          v2.TweetField.source,
          v2.TweetField.text,
          v2.TweetField.editControls,
          v2.TweetField.withheld,
        ],
      );
      log(me.data.toJson().toString());
    } on TimeoutException catch (e) {
      log(e.toString());
    } on v2.UnauthorizedException catch (e) {
      log(e.toString());
    } on v2.RateLimitExceededException catch (e) {
      log(e.toString());
    } on v2.DataNotFoundException catch (e) {
      log(e.toString());
    } on v2.TwitterUploadException catch (e) {
      log(e.toString());
    } on v2.TwitterException catch (e) {
      log(e.response.headers.toString());
      log(e.body.toString());
      log(e.toString());
    } catch (error) {
      log("tweet repo getAllTweets error: $error");
    }
  }
}
