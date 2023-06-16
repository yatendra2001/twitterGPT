// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/repositories/appwrite_repo/appwrite_repo.dart';
import 'package:twitter_gpt/screens/login/twitter_screen.dart';

import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin-screen';

  const SignInScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageTransition(
      settings: const RouteSettings(name: routeName),
      type: PageTransitionType.rightToLeft,
      child: const SignInScreen(),
    );
  }

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    child: Text("Cancel",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColor.kColorWhite)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 22.3.w),
                  Image.asset(
                    twitterGPTLogoGreen,
                    scale: 8.5,
                    filterQuality: FilterQuality.low,
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              height: 7.h,
              width: double.infinity,
              child: Text(
                "Log in to TwitterGPT",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: 5.h),
            TextField(
              controller: _emailController,
              cursorColor: AppColor.kColorGrey,
              onChanged: (value) {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                hintText: "Registered email address",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColor.kColorGrey),
                border: null,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.kColorGrey),
                ),
                filled: true,
                fillColor: AppColor.kColorGrey.withOpacity(0.1),
              ),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: _passwordController,
              onChanged: (value) {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              cursorColor: AppColor.kColorGrey,
              autofocus: true,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColor.kColorGrey),
                border: null,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.kColorGrey),
                ),
                filled: true,
                fillColor: AppColor.kColorGrey.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 9.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColor.kColorBlack,
          border: Border(
            top: BorderSide(color: AppColor.kBottomNavBarBorderColorGrey),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(
                  "Forgot Password?",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColor.kGreenColor, fontWeight: FontWeight.w600),
                ),
                onPressed: () {},
              ),
              SizedBox(
                height: 5.h,
                width: 20.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.kColorWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: isLoading == null
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });
                            final user =
                                await AppwriteRepo().signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            debugPrint("User ID: ${user!.$id}");
                            SessionHelper.uid = user.$id;
                            SessionHelper.appwriteEmail = user.email;
                            setState(() {
                              isLoading = false;
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.of(context)
                                .pushNamed(TwitterScreen.routeName);
                          },
                    child: isLoading == true
                        ? SizedBox(
                            height: 2.5.h,
                            width: 2.5.h,
                            child: const CircularProgressIndicator(
                              color: AppColor.kColorBlack,
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            "Next",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColor.kColorBlack,
                                    fontWeight: FontWeight.w600),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
