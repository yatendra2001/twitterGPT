// 📦 Package imports:
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter_gpt/config/route_generator.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

// 🌎 Project imports:
import 'firebase_options.dart';
import 'screens/onboarding/screens/pageview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_PROJECT_URL'),
    anonKey: dotenv.get('PUBLIC_ANON_KEY'),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'twitterGPT',
        theme: ThemeData.dark().copyWith(
          primaryColor: AppColor.kColorNotBlack,
          scaffoldBackgroundColor: AppColor.kColorNotBlack,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: OnboardingPageview.routeName,
      );
    });
  }
}
