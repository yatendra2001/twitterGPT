// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:twitter_gpt/screens/onboarding/screens/custom_onboarding_screen.dart';
import 'package:twitter_gpt/screens/onboarding/screens/stay_informed.dart';
import 'package:twitter_gpt/screens/onboarding/screens/welcome_screen.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class OnboardingPageview extends StatefulWidget {
  static const routeName = '/onboarding-pageview';
  const OnboardingPageview({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => const OnboardingPageview(),
    );
  }

  @override
  State<OnboardingPageview> createState() => _OnboardingPageviewState();
}

class _OnboardingPageviewState extends State<OnboardingPageview> {
  late int _page;

  @override
  void initState() {
    super.initState();
    _page = 0;
  }

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: _page != 0
            ? IconButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.linear,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColor.kColorWhite,
                ),
              )
            : null,
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 450),
            curve: Curves.linear,
          );
        },
        child: PageView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          onPageChanged: _onPageViewChange,
          children: _buildPages(),
        ),
      ),
    );
  }

  List<Widget> _buildPages() {
    return [
      WelcomeScreen(
        pageController: _pageController,
      ),
      CustomScreen(
        pageNumber: 1,
        pageController: _pageController,
        title: "Generate Tweets with Ease",
        text:
            "Craft personalized tweets and threads in your style with the power of AI, right at your fingertips.",
      ),
      CustomScreen(
        pageNumber: 2,
        pageController: _pageController,
        title: "Boost Your Twitter Engagement",
        text:
            "Discover trending topics suggested by our AI, helping you stay relevant and grow your audience.",
      ),
      StayInformedScreen(
        pageNumber: 3,
        pageController: _pageController,
        title: "Analyze and Improve",
        text:
            "Track the performance of your tweets, gain insights, and tweak your strategy for optimum Twitter growth.",
      ),
    ];
  }

  _onPageViewChange(int value) {
    setState(() {
      _page = value;
    });
  }
}
