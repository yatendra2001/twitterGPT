import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_gpt/repositories/authentication/auth_repo.dart';
import 'package:twitter_gpt/screens/homepage/homepage.dart';
import 'package:twitter_gpt/screens/onboarding/screens/onboarding_pageview.dart';
import 'package:twitter_gpt/utils/asset_constants.dart';

import '../blocs/app_init/app_init_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppInitBloc, AppInitState>(
      listenWhen: (prevState, state) => prevState.status != state.status,
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(OnboardingPageview.routeName);
        } else if (state.status == AuthStatus.authenticated) {
          Navigator.of(context).pushNamed(HomePage.routeName);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            twitterGPTLogoWhite,
            scale: 3,
          ),
        ),
      ),
    );
  }
}
