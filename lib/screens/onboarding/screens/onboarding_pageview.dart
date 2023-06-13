// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:twitter_gpt/screens/onboarding/screens/custom_onboarding_screen.dart';
import 'package:twitter_gpt/utils/onboarding_data.dart';

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
  @override
  void initState() {
    super.initState();
  }

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        clipBehavior: Clip.none,
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _buildPages(),
      ),
    );
  }

  List<Widget> _buildPages() {
    return [
      CustomScreen(
        pageName: OnboardingData.topics,
        pageController: _pageController,
        title: "What do you want to tweet about on Twitter?",
        text:
            "Select at least 3 interests to personalize your TwitterGPT experience.",
      ),
      CustomScreen(
        pageName: OnboardingData.writingStyle,
        pageController: _pageController,
        title: "What is your go to writing style?",
        text:
            "This will effect the way your tweets and replies are constructed. They can be edited in settings. Selecting multiple styles may impact accuracy.",
      ),
      CustomScreen(
        pageName: OnboardingData.conversationTone,
        pageController: _pageController,
        title: "What is your desired conversation tone?",
        text:
            "This will effect the way your tweets and replies are constructed. They can be edited in settings. Selecting multiple tones may impact accuracy.",
      ),
    ];
  }
}
