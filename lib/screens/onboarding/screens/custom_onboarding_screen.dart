// 🎯 Dart imports:

// 🐦 Flutter imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/models/user_preference.dart';
import 'package:twitter_gpt/repositories/appwrite_repo/appwrite_repo.dart';
import 'package:twitter_gpt/repositories/tweets/tweet_repo.dart';

// 🌎 Project imports:
import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/screens/navbar/bottom_navbar_screen.dart';
import 'package:twitter_gpt/utils/onboarding_data.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class CustomScreen extends StatefulWidget {
  final PageController pageController;
  static const routename = '/custom-screeen';

  final String pageName;
  final String title;
  final String text;

  const CustomScreen({
    Key? key,
    required this.pageController,
    required this.pageName,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  List<int> selectedBoxes = [];
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            child: Text("Cancel",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: AppColor.kColorWhite)),
                            onPressed: () => widget.pageName ==
                                    OnboardingData.topics
                                ? Navigator.of(context).pop()
                                : widget.pageController.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.linear)),
                        SizedBox(width: 25.w),
                        Image.asset(
                          twitterGPTLogoGreen,
                          scale: 8.5,
                          filterQuality: FilterQuality.low,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    widget.text,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.kColorGrey,
                        height: 1.5,
                        wordSpacing: 2),
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColor.kColorGrey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      OnboardingData.onboardingDataMap[widget.pageName]!.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2.h,
                      crossAxisSpacing: 4.w,
                      childAspectRatio: 2),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedBoxes.contains(index) == false) {
                            selectedBoxes.add(index);
                          } else if (selectedBoxes.contains(index) == true) {
                            selectedBoxes.remove(index);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedBoxes.contains(index) == true
                              ? AppColor.kGreenColor
                              : AppColor.kBoxesColorGrey.withOpacity(0.4),
                          border: Border.all(
                              color:
                                  AppColor.kBorderColorGrey.withOpacity(0.2)),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(18.sp),
                            child: Text(
                              OnboardingData
                                  .onboardingDataMap[widget.pageName]![index],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: AppColor.kColorWhite,
                                      fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: selectedBoxes.isEmpty == true
          ? null
          : AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInBack,
              height: 9.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColor.kColorBlack,
                border: Border(
                  top: BorderSide(color: AppColor.kBottomNavBarBorderColorGrey),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedBoxes.length > 3
                          ? "${selectedBoxes.length} selected"
                          : "${selectedBoxes.length} selected of 3 selected",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColor.kColorWhite,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.h,
                      width: 20.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.kColorWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: selectedBoxes.isEmpty
                              ? null
                              : () async {
                                  SessionHelper
                                          .userOnboardedData![widget.pageName] =
                                      selectedBoxes;
                                  debugPrint(
                                      "Session helper: ${SessionHelper.userOnboardedData}");
                                  if (widget.pageName ==
                                      OnboardingData.conversationTone) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    SessionHelper.prompt = "";
                                    final user = await TweetRepo()
                                        .getTwitterUserProfile();
                                    final ans = await AppwriteRepo()
                                        .addUserDataToUserCollection(
                                            user: user!);

                                    final ans2 = await AppwriteRepo()
                                        .addUserPreferenceToUserPreferenceDataCollection(
                                            userPreference: UserPreference(
                                      uid: SessionHelper.uid,
                                      userTopics: SessionHelper
                                          .userOnboardedData![
                                              OnboardingData.topics]
                                          ?.map((index) => OnboardingData
                                                  .onboardingDataMap[
                                              OnboardingData.topics]![index])
                                          .toList(),
                                      userWritingStyle: SessionHelper
                                          .userOnboardedData![
                                              OnboardingData.writingStyle]
                                          ?.map((index) =>
                                              OnboardingData.onboardingDataMap[
                                                  OnboardingData
                                                      .writingStyle]![index])
                                          .toList(),
                                      userWritingTone: SessionHelper
                                          .userOnboardedData![
                                              OnboardingData.conversationTone]
                                          ?.map((index) => OnboardingData
                                                  .onboardingDataMap[
                                              OnboardingData
                                                  .conversationTone]![index])
                                          .toList(),
                                      userFormattingPreferenceMap: jsonEncode({
                                        "Use plain language": true,
                                        "Use bullets": true,
                                        "Use slang (experimental)": true,
                                        "End tweets with hash tags": true,
                                      }),
                                    ));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (ans == true && ans2 == true) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushNamed(
                                          BottomNavBarScreen.routeName);
                                    }
                                  } else {
                                    widget.pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.linear);
                                  }
                                },
                          child: _isLoading == true
                              ? SizedBox(
                                  height: 2.5.h,
                                  width: 2.5.h,
                                  child: const CircularProgressIndicator(
                                    color: AppColor.kColorBlack,
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text(
                                  "Next",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: AppColor.kColorBlack,
                                          fontWeight: FontWeight.w600),
                                )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
