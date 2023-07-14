import 'package:flutter/material.dart';
import 'package:twitter_gpt/repositories/appwrite_repo/appwrite_repo.dart';
import 'package:twitter_gpt/screens/login/welcome_screen.dart';
import 'package:twitter_gpt/screens/navbar/bottom_navbar_screen.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';
import '../utils/asset_constants.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: AppwriteRepo().sessionManager.getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data?["isLoggedIn"] ?? false) {
            SessionHelper.uid = snapshot.data?["uid"];
            return const BottomNavBarScreen();
          } else {
            return const WelcomeScreen();
          }
        } else {
          return Scaffold(
            backgroundColor: AppColor.kGreenColor,
            body: Center(
              child: Image.asset(
                twitterGPTLogoWhite,
                scale: 5,
                filterQuality: FilterQuality.low,
              ),
            ),
          );
        }
      },
    );
  }
}
