// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/screens/onboarding/screens/onboarding_pageview.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';

import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiKeyScreen extends StatelessWidget {
  static const routeName = '/apikey-screen';
  const ApiKeyScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageTransition(
      settings: const RouteSettings(name: routeName),
      type: PageTransitionType.rightToLeft,
      child: const ApiKeyScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              height: 7.h,
              width: double.infinity,
              child: Text(
                "Enter your OpenAI key",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 15.h,
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                    text:
                        "To fully harness the potential of TwiiterGPT, you'll need an OpenAI key. An OpenAI key grants access to the advanced language models that power our platform, enabling us to deliver cutting-edge features and personalized recommendations.\nMore details can be found ",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.kColorGrey,
                        height: 1.5,
                        wordSpacing: 2),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final uri = Uri.https(
                                "platform.openai.com", "/account/api-keys");
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                        text: "here.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColor.kGreenColor,
                              letterSpacing: 0.5,
                              height: 1.5,
                            ),
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 5.h),
            TextField(
              cursorColor: AppColor.kColorGrey,
              autofocus: true,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "OpenAI key",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColor.kColorGrey),
                border: null,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.kColorGrey),
                ),
                filled: true,
                fillColor: AppColor.kColorGrey.withOpacity(0.1),
              ),
            ),
            SizedBox(height: 37.h),
            CustomButton(
                height: 6.3.h,
                width: double.infinity,
                text: "Continue",
                onPressed: () => Navigator.of(context)
                    .pushNamed(OnboardingPageview.routeName)),
          ],
        ),
      ),
    );
  }
}
