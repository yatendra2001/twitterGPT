// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import 'package:twitter_gpt/utils/onboarding_data.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';
  const SettingsScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SettingsScreen(),
    );
  }

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final textFormattingMap = {
    "Use emojis": true,
    "Use punctuations": true,
    "Use slang (experimental)": true,
    "End tweets with a full-stop": true,
    "Use lowercase": false,
  };
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
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                      final isSelected = SessionHelper
                          .userOnboardedData![widget.dataType]!
                          .contains(realIndex);
                      return Padding(
                        padding: EdgeInsets.only(
                            right: 8.0), // add some spacing between the chips
                        child: Chip(
                          onDeleted: () => setState(() {
                            if (isSelected) {
                              SessionHelper.userOnboardedData![widget.dataType]!
                                  .remove(realIndex);
                            } else {
                              SessionHelper.userOnboardedData![widget.dataType]!
                                  .add(realIndex);
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
          )
        ],
      ),
    );
  }
}
