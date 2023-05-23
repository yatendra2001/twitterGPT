import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_gpt/blocs/app_init/app_init_bloc.dart';
import 'package:twitter_gpt/common_widgets/custom_button.dart';
import 'package:twitter_gpt/common_widgets/custom_outlined_button.dart';
import 'package:twitter_gpt/repositories/tweets/tweet_repo.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  const HomePage({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Replace with actual user profile
  List<String>? thread;
  TweetRepo tweetRepo = TweetRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Suggested Thread',
                    style: kTitleTextStyle,
                  ),
                ),
                SizedBox(height: 8.h),
                FutureBuilder<String?>(
                  future: tweetRepo.generateTweet(SessionHelper.username!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          Center(
                            child: SpinKitWanderingCubes(
                              color: AppColor.kColorWhite,
                              size: 35.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          const Text(
                            'Generating Tweet...',
                            style: TextStyle(color: AppColor.kColorOffWhite),
                          ),
                        ],
                      );
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          '${snapshot.data}',
                          style:
                              const TextStyle(color: AppColor.kColorOffWhite),
                        );
                      }
                    }
                  },
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Transform.scale(
                        scale: 0.8,
                        child: CustomButton(
                            text: "Post Thread",
                            onPressed: () async {
                              await tweetRepo.postThread(
                                  SessionHelper.thread!.skip(1).toList());
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Thread Posted!',
                                      style: TextStyle(
                                          color: AppColor.kColorWhite)),
                                  backgroundColor: AppColor.kDarkBlueColor,
                                ),
                              );
                            })),
                    Transform.scale(
                      scale: 0.8,
                      child: CustomOutlineButton(
                        text: 'Log out',
                        onPressed: () {
                          BlocProvider.of<AppInitBloc>(context)
                              .add(AuthLogoutRequested());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
