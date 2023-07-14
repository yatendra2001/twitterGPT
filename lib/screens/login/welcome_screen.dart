// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/screens/login/signin_screen.dart';
import 'package:twitter_gpt/screens/login/signup_screen.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';

import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageTransition(
      settings: const RouteSettings(name: routeName),
      type: PageTransitionType.fade,
      child: const WelcomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 3.h),
            SizedBox(
              height: 8.h,
              width: double.infinity,
              child: Image.asset(
                twitterGPTLogoGreen,
                scale: 8.5,
                filterQuality: FilterQuality.low,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 40.h,
              width: double.infinity,
              child: Text(
                "Leverage AI to\nsupercharge your tweets\nand amplify your reach.",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            CustomButton(
              height: 6.3.h,
              width: double.infinity,
              text: "Create Account",
              onPressed: () async {
                log("Signing in");
                // await AuthRepository().loginUsingTwitter();
                // await AppwriteRepo().signInWithOAuth();
                log("SignedIn Successfully");

                Navigator.of(context).pushNamed(SignUpScreen.routeName);
              },
            ),
            SizedBox(height: 3.5.h),
            SizedBox(
              height: 10.h,
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                    text: "By signing up, you agree to our ",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.kColorGrey,
                        height: 1.5,
                        wordSpacing: 2),
                    children: [
                      TextSpan(
                        text: "Terms, ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColor.kGreenColor,
                              letterSpacing: 0.5,
                              height: 1.5,
                            ),
                      ),
                      TextSpan(
                        text: "Privacy Policy ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColor.kGreenColor,
                              letterSpacing: 0.5,
                              height: 1.5,
                            ),
                      ),
                      TextSpan(
                        text: "and ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColor.kColorGrey,
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                      TextSpan(
                        text: "Cookie Use.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColor.kGreenColor,
                              letterSpacing: 0.5,
                              height: 1.5,
                            ),
                      ),
                      TextSpan(
                        text: "\n\nHave an account already?",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColor.kColorGrey,
                            height: 1.5,
                            wordSpacing: 2),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushNamed(SignInScreen.routeName);
                          },
                        text: " Log in.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColor.kGreenColor,
                              letterSpacing: 0.5,
                              height: 1.5,
                            ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
