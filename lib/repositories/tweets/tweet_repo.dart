import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;

import 'package:twitter_gpt/repositories/tweets/base_tweet_repo.dart';
import 'package:twitter_gpt/repositories/user/user_repo.dart';
import 'package:twitter_gpt/utils/session_helper.dart';

class TweetRepo extends BaseTweetRepo {
  final v2.TwitterApi _twitter;
  late String userProfile;
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
  Future<String?> getUsername() async {
    try {
      final me = await _twitter.users.lookupMe(
        userFields: const [
          v2.UserField.id,
          v2.UserField.username,
          v2.UserField.description,
        ],
      );
      log(me.data.toJson().toString());
      return me.data.toJson()['description'];
    } catch (error) {
      log("tweet repo getAllTweets error: $error");
    }
    return null;
  }

  Future<String?> generateTweet(String userProfile) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${dotenv.get('OPEN_AI_API_KEY')}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "model": "gpt-4",
          "messages": [
            {
              "role": "user",
              "content":
                  "Analyse my Twitter profile description: $userProfile. Create a Twitter thread that I can post. Give me only thread nothing else."
            }
          ]
        }),
      );
      log(response.body.toString());
      final thread =
          jsonDecode(response.body)['choices'][0]['message']['content'];
      SessionHelper.thread = thread.split('\n\n');
      return thread;
    } catch (error) {
      log("tweet repo generateTweet error: $error");
    }
    return null;
  }

  Future<List<String>?> generateThread(Map<String, dynamic> userProfile) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${dotenv.get('OPEN_AI_API_KEY')}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "model": "gpt-4",
          "messages": [
            {"role": "user", "content": "Hello!"}
          ]
        }),
      );

      String threadText =
          jsonDecode(response.body)['choices'][0]['message']['content'];
      return threadText.split('\n\n---\n\n');
    } catch (error) {
      log("tweet repo generateThread error: $error");
    }
    return null;
  }

  Future<void> postTweet(String tweetText) async {
    try {
      await _twitter.tweets.createTweet(text: tweetText);
    } catch (error) {
      log("tweet repo postTweet error: $error");
    }
  }

  Future<List<v2.TweetData>> postThread(List<String> thread) async {
    List<v2.TweetData> postedTweets = [];

    for (final tweet in thread) {
      // Retrieve the last sent tweet
      var lastTweet = postedTweets.isNotEmpty ? postedTweets.last : null;

      // Build the tweet query params
      var tweetParam = v2.TweetParam(text: tweet);

      // Reply to an existing tweet if needed
      var inReplyToId =
          lastTweet != null ? lastTweet.id : tweetParam.reply?.inReplyToTweetId;

      if (inReplyToId != null) {
        // Post a tweet as a reply to the last one
        var postedTweet = await _twitter.tweets
            .createReply(tweetId: inReplyToId, text: tweetParam.text);
        postedTweets.add(postedTweet.data);
      } else {
        // Post a standalone tweet
        var postedTweet =
            await _twitter.tweets.createTweet(text: tweetParam.text);
        postedTweets.add(postedTweet.data);
      }
    }

    return postedTweets;
  }
}
