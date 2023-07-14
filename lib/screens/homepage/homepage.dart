// ignore_for_file: public_member_api_docs, sort_constructors_first
// 🐦 Flutter imports:
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:twitter_gpt/repositories/appwrite_repo/appwrite_repo.dart';

// 🌎 Project imports:
import 'package:twitter_gpt/repositories/tweets/tweet_repo.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/screens/homepage/write_tweet_screen.dart';
import 'package:twitter_gpt/screens/settings/settings_screen.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';
import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<String>? thread;
  TweetRepo tweetRepo = TweetRepo();
  final suggestedTopicsTweetsMap = {};

  Map<String, dynamic>? tweetData;

  @override
  void initState() {
    super.initState();
    if (SessionHelper.isHomePageLoaded == false) {
      getHomePageData();
    }
  }

  Future<void> getHomePageData() async {
    try {
      setState(() {
        SessionHelper.isHomePageLoaded = false;
      });
      debugPrint("uid: ${SessionHelper.uid}");
      SessionHelper.user =
          await AppwriteRepo().getUserData(uid: SessionHelper.uid!);
      debugPrint("user: ${SessionHelper.user!.toJson()}");
      SessionHelper.userPreference =
          await AppwriteRepo().getUserPreferenceData(uid: SessionHelper.uid!);
      debugPrint("userPreference: ${SessionHelper.userPreference!.toJson()}");
      setState(() {
        SessionHelper.isHomePageLoaded = true;
      });
      await generateTweetData();
    } catch (error) {
      debugPrint("_getHomePageData error: $error");
    }
  }

  Future<void> generateTweetData() async {
    setState(() {
      SessionHelper.isTweetDataLoaded = false;
    });
    final data = await TweetRepo().generateTweet();
    tweetData = jsonDecode(data!);
    debugPrint("tweetData: $tweetData");
    setState(() {
      SessionHelper.isTweetDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: SessionHelper.userPreference!.userTopics!.length,
          child: NestedScrollView(
            headerSliverBuilder: (_, __) {
              return [
                SliverAppBar(
                  toolbarHeight: 8.h,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  leading: Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Image.asset(
                      twitterGPTLogoGreen,
                      scale: 15,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                  title: Text(
                    "Generate tweets",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: IconButton(
                        icon: Icon(
                          Icons.replay_outlined,
                          color: AppColor.kGreenColor,
                          size: 18.sp,
                        ),
                        onPressed: () async {
                          await generateTweetData();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: IconButton(
                        icon: Icon(
                          Icons.filter_list_outlined,
                          color: AppColor.kGreenColor,
                          size: 18.sp,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SettingsScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
                if (SessionHelper.isHomePageLoaded!)
                  PreferredSize(
                    preferredSize: Size.zero,
                    child: SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      primary: false,
                      toolbarHeight: 0.h,
                      bottom: TabBar(
                        isScrollable: true,
                        unselectedLabelStyle: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(
                                color: AppColor.kUnselectedTabLabelColorGrey),
                        indicatorColor: AppColor.kGreenColor,
                        labelColor: AppColor.kColorWhite,
                        labelStyle: Theme.of(context).textTheme.labelLarge!,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: SessionHelper.userPreference!.userTopics!
                            .map((topic) => Tab(
                                  text: topic,
                                ))
                            .toList(),
                      ),
                    ),
                  )
              ];
            },
            body: SessionHelper.isTweetDataLoaded!
                ? TabBarView(
                    children: SessionHelper.userPreference!.userTopics!
                        .map((topic) => TabsStatelessWidget(
                              tweetData: tweetData![topic],
                            ))
                        .toList(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SpinKitDoubleBounce(
                        color: AppColor.kColorWhite,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Generating tweets...\nThis might take a while. Please wait.",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColor.kColorWhite),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(WriteTweetScreen.routeName);
        },
        backgroundColor: AppColor.kGreenColor,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: AppColor.kColorWhite,
        ),
      ),
    );
  }
}

class TabsStatelessWidget extends StatelessWidget {
  final List<dynamic> tweetData;
  const TabsStatelessWidget({
    Key? key,
    required this.tweetData,
  }) : super(key: key);

  TextSpan buildTextSpans(
      String text, TextStyle normalStyle, TextStyle hashtagStyle) {
    List<String> words = text.split(' ');
    List<TextSpan> spans = [];
    for (var word in words) {
      if (word.startsWith('#')) {
        spans.add(TextSpan(text: '$word ', style: hashtagStyle));
      } else {
        spans.add(TextSpan(text: '$word ', style: normalStyle));
      }
    }
    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: ListView.separated(
          itemBuilder: (context, index) => SizedBox(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: AppColor
                              .kPlaceholderProfileImageBackgroundColorGrey,
                          backgroundImage:
                              SessionHelper.user?.profileImageUrl == null
                                  ? null
                                  : CachedNetworkImageProvider(
                                      SessionHelper.user!.profileImageUrl!),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: SessionHelper.user?.name ?? "No Name",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: AppColor.kColorWhite,
                                        height: 1.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "\t@${SessionHelper.user?.username ?? "No username"}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppColor.kUsernameColorGrey,
                                            letterSpacing: 0.5,
                                            height: 1.5,
                                          ),
                                    ),
                                  ]),
                            ),
                            SizedBox(height: .5.h),
                            SizedBox(
                              width: 80.w,
                              child: RichText(
                                text: buildTextSpans(
                                    tweetData[index],
                                    Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: AppColor.kColorWhite,
                                          height: 1.2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                    Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: AppColor
                                              .kGreenColor, //color for hashtag
                                          height: 1.2,
                                          fontWeight: FontWeight.w400,
                                        )),
                              ),
                            ),
                            SizedBox(height: 2.5.h),
                            SizedBox(
                              width: 79.w,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CustomButton(
                                  height: 4.5.h,
                                  width: 30.w,
                                  text: "Tweet",
                                  isColorGreen: true,
                                  padding: 4.w,
                                  onPressed: () {
                                    SessionHelper.tweet = tweetData[index];

                                    Navigator.of(context)
                                        .pushNamed(WriteTweetScreen.routeName);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: .5.h),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => Divider(
                color: AppColor.kColorGrey,
                height: 4.h,
              ),
          itemCount: tweetData.length),
    );
  }
}
