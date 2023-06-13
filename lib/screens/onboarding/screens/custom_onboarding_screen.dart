// 🎯 Dart imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
                          child: Text(
                            "Next",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColor.kColorBlack,
                                    fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            debugPrint("page name: ${widget.pageName}");
                            debugPrint("selected box: $selectedBoxes");
                            SessionHelper.userOnboardedData![widget.pageName] =
                                selectedBoxes;
                            debugPrint(
                                "Session helper: ${SessionHelper.userOnboardedData}");
                            if (widget.pageName ==
                                OnboardingData.conversationTone) {
                              Navigator.of(context)
                                  .pushNamed(BottomNavBarScreen.routeName);
                            } else {
                              widget.pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.linear);
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
