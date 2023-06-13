// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/screens/onboarding/screens/apikey_screen.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';

import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => const LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon: Image.asset(
                twitterLogo,
                scale: 13,
                filterQuality: FilterQuality.low,
              ),
              text: "Continue with Twitter",
              onPressed: () =>
                  Navigator.of(context).pushNamed(ApiKeyScreen.routeName),
            ),
            SizedBox(height: 3.5.h),
            SizedBox(
              height: 10.h,
              width: double.infinity,
              child: Text(
                "Rest assured, we will never post without your consent. Our authorization process is safe and secure, ensuring your privacy is respected. ",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColor.kColorGrey,
                    letterSpacing: 0.5,
                    height: 1.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
