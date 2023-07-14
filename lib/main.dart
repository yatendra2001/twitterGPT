// 🎯 Dart imports:
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/config/route_generator.dart';
import 'package:twitter_gpt/firebase_options.dart';
import 'package:twitter_gpt/repositories/tweets/tweet_repo.dart';
import 'package:twitter_gpt/screens/splashscreen.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

// 🌎 Project imports:
import 'blocs/app_init/app_init_bloc.dart';
import 'repositories/authentication/auth_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
          RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
          RepositoryProvider<TweetRepo>(create: (_) => TweetRepo()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppInitBloc>(
              create: (context) =>
                  AppInitBloc(authRepository: context.read<AuthRepository>()),
            ),
          ],
          child: Portal(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'twitterGPT',
              theme: ThemeData.dark().copyWith(
                brightness: Brightness.dark,
                primaryColor: AppColor.kGreenColor,
                scaffoldBackgroundColor: AppColor.kColorBlack,
                appBarTheme: const AppBarTheme(
                  backgroundColor: AppColor.kColorBlack,
                ),
                textTheme:
                    GoogleFonts.interTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: AppColor.kColorWhite),
              ),
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: SplashScreen.routeName,
            ),
          ),
        ),
      );
    });
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    log(event.toString());
    super.onEvent(bloc, event!);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log(transition.toString());
    super.onTransition(bloc, transition);
  }

  @override
  Future<void> onError(
      BlocBase bloc, Object error, StackTrace stackTrace) async {
    log(error.toString());
    super.onError(bloc, error, stackTrace);
  }
}
