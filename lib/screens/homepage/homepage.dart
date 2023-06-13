// 🐦 Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:twitter_gpt/repositories/tweets/tweet_repo.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';
import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/utils/onboarding_data.dart';
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
  // Replace with actual user profile
  List<String>? thread;
  TweetRepo tweetRepo = TweetRepo();
  final ScrollController _scrollController = ScrollController();

  final suggestedTopicsTweetsMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: SessionHelper.userOnboardedData![OnboardingData.topics]!.length,
        child: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              SliverAppBar(
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
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: IconButton(
                      icon: Icon(
                        Icons.filter_list_outlined,
                        color: AppColor.kGreenColor,
                        size: 18.sp,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              PreferredSize(
                preferredSize: Size.zero,
                child: SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  primary: false,
                  toolbarHeight: 2.5.h,
                  bottom: TabBar(
                    isScrollable: true,
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColor.kUnselectedTabLabelColorGrey),
                    indicatorColor: AppColor.kGreenColor,
                    labelColor: AppColor.kColorWhite,
                    labelStyle: Theme.of(context).textTheme.labelLarge!,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      for (var topic in SessionHelper
                          .userOnboardedData![OnboardingData.topics]!)
                        Tab(
                          text: OnboardingData
                              .onboardingDataMap[OnboardingData.topics]![topic],
                        )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: SessionHelper.userOnboardedData![OnboardingData.topics]!
                .map((topic) => TabsStatelessWidget())
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
  const TabsStatelessWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: ListView.separated(
          itemBuilder: (context, index) => Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor
                            .kPlaceholderProfileImageBackgroundColorGrey,
                        child: SessionHelper.profileImageUrl == null
                            ? null
                            : CachedNetworkImage(
                                imageUrl: SessionHelper.profileImageUrl!),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Fahem Ahmed",
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
                                    text: "\t@slewdd",
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
                            child: Text(
                              "In the age of Eldoria, when the stars danced in harmony and magic flowed through the land, a brave hero rose from humble beginnings. With a sword of ethereal fire and a heart filled with determination, they embarked on a perilous quest to save the realms from the encroaching darkness.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColor.kColorWhite,
                                    height: 1.2,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                onPressed: () {},
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
          separatorBuilder: (context, index) => Divider(
                color: AppColor.kColorGrey,
                height: 4.h,
              ),
          itemCount: 50),
    );
  }
}
