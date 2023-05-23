// Packages Import
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import 'package:twitter_gpt/screens/onboarding/widgets/dot_indicator.dart';

import '../../../common_widgets/custom_button.dart';
import '../../../utils/asset_constants.dart';

class WelcomeScreen extends StatefulWidget {
  final PageController pageController;
  static const routename = '/welcome';
  const WelcomeScreen({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 100.h,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildAnimation(),
              SizedBox(height: 3.h),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            "Welcome to TwitterGPT",
                            style: GoogleFonts.lexend().copyWith(
                                fontWeight: FontWeight.w700, fontSize: 28.sp),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "Your personal AI-powered Twitter companion, making tweeting effortless and engaging.",
                            style: GoogleFonts.lexend().copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: const Color(0XFF8F9BBA),
                              height: 1.5,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          CustomDotIndicator(
                            curPageIndex: 0,
                            onTap: (page) {
                              widget.pageController.jumpToPage(page.round());
                            },
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomButton(
                            text: "Continue",
                            onPressed: () {
                              widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimation() {
    return Expanded(
      flex: 2,
      child: LottieBuilder.asset(
        kPage1Animation,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
