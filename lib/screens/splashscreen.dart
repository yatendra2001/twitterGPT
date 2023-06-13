import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_gpt/screens/login/login_screen.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';
import '../screens/homepage/homepage.dart';
import '../utils/asset_constants.dart';
import '../blocs/app_init/app_init_bloc.dart';

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
    return BlocListener<AppInitBloc, AppInitState>(
      listenWhen: (prevState, state) => prevState.status != state.status,
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        } else if (state.status == AuthStatus.authenticated) {
          Navigator.of(context).pushNamed(HomePage.routeName);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.kGreenColor,
        body: Center(
          child: Image.asset(
            twitterGPTLogoWhite,
            scale: 5,
            filterQuality: FilterQuality.low,
          ),
        ),
      ),
    );
  }
}
