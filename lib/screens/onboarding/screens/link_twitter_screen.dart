// 🎯 Dart imports:
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/repositories/authentication/auth_repo.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

// 🌎 Project imports:
import '../../../utils/asset_constants.dart';

class LinkTwitterScreen extends StatefulWidget {
  final Function() afterConnect;
  static const routename = '/link-wallet-screen';

  const LinkTwitterScreen({
    Key? key,
    required this.afterConnect,
  }) : super(key: key);

  @override
  State<LinkTwitterScreen> createState() => _LinkTwitterScreenState();
}

class _LinkTwitterScreenState extends State<LinkTwitterScreen> {
  final String _result = '';
  bool logoutVisible = false;
  bool _showSecond = false;

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: AppColor.kColorNotBlack,
      ),
      width: double.infinity,
      duration: const Duration(milliseconds: 400),
      child: AnimatedCrossFade(
        firstChild: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 1.h,
                  decoration: BoxDecoration(
                      color: AppColor.kColorOffWhite,
                      borderRadius: BorderRadius.circular(40)),
                  width: 30.w,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Icon(
                Icons.login,
                color: const Color(0XFF707EAE),
                size: 6.h,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Connect with twitter",
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w600,
                  fontSize: 19.87.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Login with your twitter account to continue",
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: const Color(0XFF8F9BBA),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // side: const BorderSide(color: AppColor.kColorWhite, width: 1),
                  backgroundColor: AppColor.kColorWhite,
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                onPressed: () async {
                  log("Signing in");
                  await AuthRepository().loginUsingTwitter();
                  log("SignedIn Successfully");
                  setState(() {
                    _showSecond = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.twitter,
                          color: AppColor.kColorWhite,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      "Sign in with twitter",
                      style: GoogleFonts.inter().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        color: AppColor.kColorWhite,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
        secondChild: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Congratulations 🎉",
                style: GoogleFonts.lexend(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Lottie.asset(kConfettiJson, height: 25.h),
              // CustomButton(onPressed: widget.afterConnect, text: "Okay"),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
        crossFadeState:
            _showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  demo() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Visibility(
          visible: !logoutVisible,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Icon(
                Icons.flutter_dash,
                size: 80,
                color: Color(0xFF1389fd),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Web3Auth',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Color(0xFF0364ff)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Welcome to Web3Auth x Flutter Demo',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Login with',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Google')),
              ElevatedButton(onPressed: () {}, child: const Text('Facebook')),
              ElevatedButton(
                  onPressed: () {}, child: const Text('Email Passwordless')),
              ElevatedButton(onPressed: () {}, child: const Text('Discord')),
            ],
          ),
        ),
        Visibility(
          // ignore: sort_child_properties_last
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red[600] // This is what you need!
                        ),
                    onPressed: () {},
                    child: const Column(
                      children: [
                        Text('Logout'),
                      ],
                    )),
              ),
            ],
          ),
          visible: logoutVisible,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_result),
        )
      ],
    ));
  }

  customModalBottomSheet() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 10.h,
            width: 100.w,
            child: const TextField(
              // controller: _walletAddressController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.kGreenColor)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.kGreenColor)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.kGreenColor,
                  ),
                ),
                labelStyle: TextStyle(color: AppColor.kGreenColor),
                hintStyle: TextStyle(color: AppColor.kGreenColor),
                labelText: 'NFT Name',
              ),
            ),
          ),
          Transform.scale(
            scale: 0.7,
            // child: CustomOutlineButton(text: "Done", onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
