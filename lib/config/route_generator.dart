import 'package:flutter/material.dart';
import 'package:twitter_gpt/screens/homepage/homepage.dart';
import 'package:twitter_gpt/screens/onboarding/screens/onboarding_pageview.dart';

import '../screens/splashscreen.dart';

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
      case HomePage.routeName:
        return HomePage.route();

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
