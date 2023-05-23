import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/common_widgets/custom_button.dart';
import 'package:twitter_gpt/screens/onboarding/screens/link_twitter_screen.dart';
import '../../../utils/asset_constants.dart';
import '../widgets/dot_indicator.dart';

class StayInformedScreen extends StatefulWidget {
  final PageController pageController;
  static const routename = '/custom-screeen';

  final double pageNumber;
  final String title;
  final String text;

  const StayInformedScreen({
    Key? key,
    required this.pageController,
    required this.pageNumber,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  State<StayInformedScreen> createState() => _StayInformedScreenState();
}

class _StayInformedScreenState extends State<StayInformedScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return LinkTwitterScreen(
              afterConnect: () {},
            );
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAnimation(),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        SizedBox(
                          height: 4.h,
                        ),
                        CustomDotIndicator(
                          curPageIndex: widget.pageNumber,
                          onTap: (page) {
                            widget.pageController.jumpToPage(page.round());
                          },
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        CustomButton(
                          text: "Get Started",
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return LinkTwitterScreen(
                                  afterConnect: () {},
                                );
                              },
                            );
                          },
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
      ),
    );
  }

  Widget buildAnimation() {
    return Expanded(
      flex: 3,
      child: Lottie.asset(kPage4Animation),
    );
  }
}
