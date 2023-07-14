// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/models/user_preference.dart';
import 'package:twitter_gpt/repositories/appwrite_repo/appwrite_repo.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';

import 'package:twitter_gpt/utils/onboarding_data.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';
  const SettingsScreen({super.key});
  static Route route() {
    return PageTransition(
        settings: const RouteSettings(name: routeName),
        child: const SettingsScreen(),
        type: PageTransitionType.rightToLeft);
  }

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Map<String, dynamic> textFormattingMap;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    textFormattingMap =
        jsonDecode(SessionHelper.userPreference!.userFormattingPreferenceMap)
            as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.kColorBlack,
          title: Text(
            'Settings',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w900),
          ),
          centerTitle: true,
          leading: _isLoading == true
              ? null
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.kColorWhite,
                  ),
                ),
          actions: [
            Transform.scale(
              scale: 0.7,
              child: CustomButton(
                height: 3.h,
                width: 25.w,
                padding: 0,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  SessionHelper.userPreference = UserPreference(
                      uid: SessionHelper.uid,
                      userFormattingPreferenceMap:
                          jsonEncode(textFormattingMap),
                      userTopics: SessionHelper.userPreference!.userTopics,
                      userWritingStyle:
                          SessionHelper.userPreference!.userWritingStyle,
                      userWritingTone:
                          SessionHelper.userPreference!.userWritingTone);
                  await AppwriteRepo()
                      .updateUserPreferenceToUserPreferenceDataCollection(
                          userPreference: SessionHelper.userPreference!);

                  setState(() {
                    _isLoading = false;
                    SessionHelper.isHomePageLoaded = false;
                  });
                },
                text: "Save",
                isColorGreen: true,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (_isLoading == true)
                const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(
                      color: AppColor.kGreenColor,
                    )),
              const Divider(
                color: AppColor.kColorGrey,
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Text formatting",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "Personalize the formatting of your generated tweets. ",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: AppColor.kColorGrey),
                    ),
                    SizedBox(height: 2.h),
                    for (String item in textFormattingMap.keys)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Checkbox(
                              value: textFormattingMap[item],
                              activeColor: AppColor.kGreenColor,
                              onChanged: (isChecked) {
                                setState(() {
                                  textFormattingMap[item] = isChecked!;
                                });
                              }),
                        ],
                      ),
                  ],
                ),
              ),
              Divider(
                color: AppColor.kColorGrey,
                height: 6.h,
              ),
              const SetttingsChipsWidget(
                title: "Topics of interest",
                subtitle:
                    "Select at least 3 interests to personalize your TwitterGPT experience.",
                dataType: OnboardingData.topics,
              ),
              Divider(
                color: AppColor.kColorGrey,
                height: 6.h,
              ),
              const SetttingsChipsWidget(
                title: "Writing style",
                subtitle:
                    "This will effect the way your tweets and replies are constructed. Selecting multiple styles may impact accuracy.",
                dataType: OnboardingData.writingStyle,
              ),
              Divider(
                color: AppColor.kColorGrey,
                height: 6.h,
              ),
              const SetttingsChipsWidget(
                title: "Conversational tone",
                subtitle:
                    "This will effect the way your tweets and replies are constructed. Selecting multiple tones may impact accuracy.",
                dataType: OnboardingData.writingStyle,
              ),
              Divider(
                color: AppColor.kColorBlack,
                height: 6.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SetttingsChipsWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final String dataType;
  const SetttingsChipsWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.dataType,
  }) : super(key: key);

  @override
  State<SetttingsChipsWidget> createState() => _SetttingsChipsWidgetState();
}

class _SetttingsChipsWidgetState extends State<SetttingsChipsWidget> {
  late List<String> labelDataList;
  @override
  void initState() {
    super.initState();
    labelDataList = widget.dataType == OnboardingData.topics
        ? SessionHelper.userPreference!.userTopics!
        : widget.dataType == OnboardingData.writingStyle
            ? SessionHelper.userPreference!.userWritingStyle!
            : SessionHelper.userPreference!.userWritingTone!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 0.7.h),
          Text(
            widget.subtitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: AppColor.kColorGrey),
          ),
          SizedBox(height: 3.h),
          Column(
            children: [
              SizedBox(height: 1.h),
              for (int i = 0; i < 3; i++)
                SizedBox(
                  height: 5.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (OnboardingData
                                .onboardingDataMap[widget.dataType]!.length /
                            3)
                        .ceil(),
                    itemBuilder: ((context, index) {
                      final realIndex = index +
                          i *
                              (OnboardingData
                                          .onboardingDataMap[widget.dataType]!
                                          .length /
                                      3)
                                  .ceil();
                      if (realIndex >=
                          OnboardingData.onboardingDataMap[widget.dataType]!
                              .length) return null;
                      final isSelected = labelDataList.contains(OnboardingData
                          .onboardingDataMap[widget.dataType]![realIndex]);
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0), // add some spacing between the chips
                        child: Chip(
                          onDeleted: () => setState(() {
                            if (isSelected) {
                              labelDataList.remove(
                                  OnboardingData.onboardingDataMap[
                                      widget.dataType]![realIndex]);
                              debugPrint(SessionHelper
                                  .userPreference!.userTopics
                                  .toString());
                              debugPrint(SessionHelper
                                  .userPreference!.userWritingStyle
                                  .toString());
                              debugPrint(SessionHelper
                                  .userPreference!.userWritingTone
                                  .toString());
                            } else {
                              labelDataList.add(
                                  OnboardingData.onboardingDataMap[
                                      widget.dataType]![realIndex]);
                              debugPrint(SessionHelper
                                  .userPreference!.userTopics
                                  .toString());
                              debugPrint(SessionHelper
                                  .userPreference!.userWritingStyle
                                  .toString());
                              debugPrint(SessionHelper
                                  .userPreference!.userWritingTone
                                  .toString());
                            }
                          }),
                          backgroundColor: isSelected
                              ? AppColor.kGreenColor
                              : AppColor.kColorBlack,
                          label: Text(OnboardingData
                              .onboardingDataMap[widget.dataType]![realIndex]),
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                          labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
                          deleteIcon: FaIcon(
                            isSelected
                                ? FontAwesomeIcons.minus
                                : FontAwesomeIcons.plus,
                            color: isSelected
                                ? AppColor.kColorWhite
                                : AppColor.kGreenColor,
                            size: 10.sp,
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? AppColor.kGreenColor
                                : AppColor.kColorGrey,
                            width: 0.5,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              SizedBox(height: 1.h),
            ],
          ),
        ],
      ),
    );
  }
}
