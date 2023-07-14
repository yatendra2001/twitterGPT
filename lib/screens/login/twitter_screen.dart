// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/repositories/authentication/auth_repo.dart';
import 'package:twitter_gpt/screens/onboarding/screens/onboarding_pageview.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';

import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class TwitterScreen extends StatefulWidget {
  static const routeName = '/twitter-screen';
  const TwitterScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageTransition(
      settings: const RouteSettings(name: routeName),
      type: PageTransitionType.rightToLeft,
      child: const TwitterScreen(),
    );
  }

  @override
  State<TwitterScreen> createState() => _TwitterScreenState();
}

class _TwitterScreenState extends State<TwitterScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 22.3.w),
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
              height: 6.h,
              width: double.infinity,
              child: Text(
                "Create an account",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            Text(
                "Welcome to TwitterGPT! Please enter the following details to create an account.",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColor.kColorGrey,
                      height: 1.5,
                      wordSpacing: 2,
                    )),
            SizedBox(height: 40.h),
            _isLoading == true
                ? SizedBox(
                    height: 2.5.h,
                    width: 2.5.h,
                    child: const CircularProgressIndicator(
                      color: AppColor.kColorWhite,
                      strokeWidth: 3,
                    ),
                  )
                : CustomButton(
                    height: 6.3.h,
                    width: double.infinity,
                    icon: Image.asset(
                      twitterLogo,
                      scale: 13,
                      filterQuality: FilterQuality.low,
                    ),
                    text: "Continue with Twitter",
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      log("Signing in");
                      await AuthRepository().loginUsingTwitter();
                      // await AppwriteRepo().signInWithOAuth();
                      log("SignedIn Successfully");
                      setState(() {
                        _isLoading = false;
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.of(context)
                          .pushNamed(OnboardingPageview.routeName);
                    },
                  ),
            SizedBox(height: 3.5.h),
            SizedBox(
              height: 10.h,
              width: double.infinity,
              child: Text(
                "Rest assured, we will never post without your consent. Our authorization process is safe and secure, ensuring your privacy is respected.",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColor.kColorGrey, height: 1.5, wordSpacing: 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
