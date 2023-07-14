// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;
import 'package:twitter_gpt/models/user_model.dart';

// 🌎 Project imports:
import 'package:twitter_gpt/repositories/tweets/base_tweet_repo.dart';
import 'package:twitter_gpt/utils/session_helper.dart';

class TweetRepo extends BaseTweetRepo {
  final v2.TwitterApi _twitter;
  late String userProfile;
  TweetRepo({v2.TwitterApi? twitter})
      : _twitter = twitter ??
            v2.TwitterApi(
              bearerToken: '',
              oauthTokens: v2.OAuthTokens(
                consumerKey: dotenv.get('API_KEY'),
                consumerSecret: dotenv.get('API_SECRET_KEY'),
                accessToken: SessionHelper.user?.accessToken ??
                    dotenv.get('ACCESS_TOKEN'),
                accessTokenSecret: SessionHelper.user?.accessTokenSecret ??
                    dotenv.get('ACCESS_TOKEN_SECRET'),
              ),
            );
  @override
  Future<User?> getTwitterUserProfile() async {
    try {
      final me = await _twitter.users.lookupMe(
        userFields: const [
          v2.UserField.id,
          v2.UserField.name,
          v2.UserField.username,
          v2.UserField.description,
          v2.UserField.url,
          v2.UserField.profileImageUrl,
        ],
      );
      log(me.data.toJson().toString());
      return User(
        uid: SessionHelper.uid,
        accessToken: SessionHelper.accessToken,
        accessTokenSecret: SessionHelper.accessTokenSecret,
        name: me.data.name,
        username: me.data.username,
        profileImageUrl: me.data.profileImageUrl,
        email: SessionHelper.appwriteEmail ?? "yatendra2001kumar@gmail.com",
      );
    } catch (error) {
      log("tweet repo getAllTweets error: $error");
    }
    return null;
  }

  @override
  Future<String?> generateTweet() async {
    try {
      final userFormattingPreferenceMap =
          jsonDecode(SessionHelper.userPreference!.userFormattingPreferenceMap);

      SessionHelper.prompt = '''
You're a Twitter content creator expert who helps users write viral Twitter tweets. I need you to write 5 unique tweets on the following topics under a list:
${SessionHelper.userPreference!.userTopics}

STRICTLY adhere to following set of guidelines before writing the tweets:

• Use different combinations of ${SessionHelper.userPreference!.userWritingStyle!.join(",")} writing styles along with ${SessionHelper.userPreference!.userWritingTone!.join(",")} tones. Strictly use only 1 writing style and with only 1 tone to combine together.
• ${userFormattingPreferenceMap["Use bullets"] ? "Give properly formatted tweets, with bullet points and line gaps for free space." : "Don't use bullet points."} 
• ${userFormattingPreferenceMap["End tweets with hash tags"] ? "End tweets with 2 or 3 hashtags" : "Don't use hashtags"}
• Use "\n" to change the line, "\n\n" for creating a line gap, "-" for bullet points.
• Create a line gap before and after bullet points, and change the line for hashtags.
• Don't use emojis.
• ${userFormattingPreferenceMap["Use plain language"] == false ? "Use plain language" : ""}. 
• Use 200 characters minimum and 250 maximum  for a tweet. 
• Give an answer in the following JSON Encoded format, keeping keys as topics string and values as string list of generated tweets.
• Give me the JSON only nothing else.
• Use following 30 templates for inspiration provided under three backticks delimiter ``` each separated by three dashes --- to create a personalised hook for the tweet, be creative, you are not limited to my words:

```
Want to be a ------------- in ----- Days? Then give clear steps to complete.
Example: Want to be a data analyst in 100 days?

---- Best -----
Example: 10 Best Courses to Learn Email Marketing

---

Attractive Statistics of a Tool/Software/Project/Person Want to ----------------
(Asking a Question your Audience had to say Yes) 
 
Attractive, Eye-Catching Statistics in a pattern.(solution/steps to achieve)
  
---

You ------ before 
You ---- Now

Example:

You 3 years ago: 
You are now:

---

A General Statement about your Main Point (in here technologies) 
The fear and Pain (in here, you will be left behind)
The Solution, (in here, Learn these 10 Technologies)
    
---

---- Skills that will Pay you --------/month or year.
Example: 10 Application that will help you to save \$1,000/month
 
---

The ---- Stages of -----
Stage 1:
Stage 2:
(Clear, precious short process to achieve success)
  
---

---- Best -------- to find/get-------
(Try to guide and solve the exact problem of your audience)
Example: 10 Best Tools for Email Marketers to double the conversion rate:

---


Want to ---------- and get paid well?
Here are ------- websites/tools/programs/course/people that ------ 

Example: Want to 6 packs abs in 6 months?
Here is the schedule you need to follow.
  
---

----- Million/Billion use/want/------------
Want to-------------? 
Here are ------ tricks/hacks/------------

Example: 10 million People use Canva.

Want to Learn Canva less than 1 hour?
Here are 10 Lessons you need to master Canva.
 
---

.....A....vs B... Explained
Example: Canva vs Photoshop Explained.
Data Analysis vs Data Science Explained.
  
---

----- Steps to Become a -------- List steps clearly.
Examples:
-10 Steps to Become a Data Analyst
-10 Steps to close your first ghostwriting client.
 
---

Your ------ Levels:
Level 1:
Level 2:

Example: Your Maturity Levels:
Level 1: Argue everything
Level 2: Argue but start listening
Level 3: ------ Hope you got what I mean... :P
  
---

Need to----->?
------- if free
Example: Need a storage?
➢ Google Drive is free.... 

---

Powerful ------ to ------:
Example: 10 People to help you to Learn Email Marketing: -
    
---

----mindsets you need from ------
(Don’t limit this to mindset only)

Example:
10 Documentaries you need to watch before 30:

---

----- Guaranteed------ that can------
Choose One and Start Now
(Tip: People like straight forward clear paths)

Example: 
5 Guaranteed skill that can help you to make \$10,000/month: Choose one and start now.
  
---

More than -------- people use.......(stats about a tool/product/person) Want to------- (Your audience pain/desire)
Here are 10 -------- in ---- minutes/hours

Example: 
99% businesses use Emails
Want to Increase Sales using Email Marketing?
Here are 10 Best Email Marketing Strategies for e-com store managers.

---

----- Skills that will--------
Example: 10 Courses that will help you to land \$10,000/month Job. Here is how you can get these courses for free.
   
---

Before and After
Example: One Year Ago Today: -
-
Today:
-
 
---

If you have --------- you can get--------
Here is how you can do it.

Example: 

If you can write high engaging Tweets, you can build a 6-figure business.
Here is how you can do it.
Tip: If you can write your own story/your process once you have done it, it works way better than explaining a process.
  
---

Want to Create ----------
Next level:

Example: 
Want to Build a Twitter Audience? 
-
Next Level:
-

---

The Level of----
Level1:
Example: The Levels of Freedom, The Stages to reach your first \$10,000 client. Tip: People love step by step process/path to reach success. It should be clear.
  
---

----- Habits to Build in ------
Relate to your audience.
Example: 10 Lessons to Learn in your 20s: or 20 Habits to build your Body in 20s:
 
---

Beginners’ Mistakes as a ----------:
Example: Beginners’ Mistakes as a Data Analyst/Email Marketer/Web Designer:
Tip: If you are writing a list, pay attention to how you are presenting it, as you can see below, how I have arranged points.
  
---

One side vs other side.
Example: 9-5 Job vs Solopreneur.

---

The Best Advice/Tips/Hacks/ I can give you about ----------
The more you specify your audience interest, the more engagement you will get. 

Example: The Best Hacks for Email Marketers:
    
---

Someone made------ from------
Someone made ----------- from --------

Finish the tweet with a key message/a question?

Example:
Someone made \$1M from coding
Someone made \$1M from selling cookies

Find what you're best at!

---

Looking for ---------?
I have----------- (why you have the authority to talk about it) 

Here are -------- steal these 
Free Now (create urgency)
    
---

What -------- is Not about:
What -------- is about:
(The correct and wrong way)

Example: 

What Investing is NOT about:
What Investing is about
```
''';

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
              "content": SessionHelper.prompt,
            }
          ],
          "max_tokens": 2000,
        }),
      );
      log(response.body.toString());
      final tweet =
          jsonDecode(response.body)['choices'][0]['message']['content'];

      return tweet;
    } catch (error) {
      debugPrint("tweet repo generateTweet error: $error");
    }
    return null;
  }

  @override
  Future<List<String>?> generateThread({required String userProfile}) async {
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
              "content": "Hello!",
            }
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

  @override
  Future<void> postTweet(
      {required String tweetText, required tweetMediaID}) async {
    try {
      final tweet = await _twitter.tweets.createTweet(
          text: tweetText,
          media: tweetMediaID.isNotEmpty
              ? v2.TweetMediaParam(mediaIds: [tweetMediaID])
              : null);
      debugPrint("tweet repo postTweet: ${tweet.data.toJson()}");
    } catch (error) {
      log("tweet repo postTweet error: $error");
    }
  }

  @override
  Future<List<v2.TweetData>> postThread({required List<String> thread}) async {
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
