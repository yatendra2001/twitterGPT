// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:twitter_gpt/screens/homepage/write_tweet_screen.dart';
import 'package:twitter_gpt/screens/login/twitter_screen.dart';

// 🌎 Project imports:
import 'package:twitter_gpt/screens/login/welcome_screen.dart';
import 'package:twitter_gpt/screens/login/signin_screen.dart';
import 'package:twitter_gpt/screens/login/signup_screen.dart';
import 'package:twitter_gpt/screens/navbar/bottom_navbar_screen.dart';
import 'package:twitter_gpt/screens/onboarding/screens/apikey_screen.dart';
import 'package:twitter_gpt/screens/onboarding/screens/onboarding_pageview.dart';
import 'package:twitter_gpt/screens/settings/settings_screen.dart';
import 'package:twitter_gpt/screens/splashscreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );

      case OnboardingPageview.routeName:
        return OnboardingPageview.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case BottomNavBarScreen.routeName:
        return BottomNavBarScreen.route();
      case WelcomeScreen.routeName:
        return WelcomeScreen.route();
      case SignInScreen.routeName:
        return SignInScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      case TwitterScreen.routeName:
        return TwitterScreen.route();
      case ApiKeyScreen.routeName:
        return ApiKeyScreen.route();
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      case WriteTweetScreen.routeName:
        return WriteTweetScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(
                child: Text(
                  'Something Went Wrong!',
                  style: TextStyle(color: Colors.grey[600], fontSize: 24),
                ),
              ),
            ));
  }
}
