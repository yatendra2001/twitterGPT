// 🎯 Dart imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

// 🌎 Project imports:
import '../../../common_widgets/custom_button.dart';
import '../../../utils/asset_constants.dart';
import '../widgets/dot_indicator.dart';

class CustomScreen extends StatefulWidget {
  final PageController pageController;
  static const routename = '/custom-screeen';

  final double pageNumber;
  final String title;
  final String text;

  const CustomScreen({
    Key? key,
    required this.pageController,
    required this.pageNumber,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildAnimation(),
                SizedBox(height: 5.h),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              widget.title,
                              style: GoogleFonts.lexend().copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 24.sp),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              widget.text,
                              style: GoogleFonts.lexend().copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
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
                              curPageIndex: widget.pageNumber,
                              onTap: (page) {
                                widget.pageController.jumpToPage(page.round());
                              },
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            CustomButton(
                              text: "Continue",
                              onPressed: () {
                                widget.pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.linear,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAnimation() {
    return Expanded(
      flex: 2,
      child: LottieBuilder.asset(
        widget.pageNumber == 1.0
            ? kPage2Animation
            : widget.pageNumber == 2.0
                ? kPage3Animation
                : "",
      ),
    );
  }
}
