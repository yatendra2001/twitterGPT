import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppColor {
  static const Color kGreenColor = Color(0xff00BA7C);
  static const Color kColorOffWhite = Color(0xffF6F8FD);
  static const Color kColorWhite = Color(0xffFFFFFF);
  static const Color kColorNotBlack = Color(0xff131313);
  static const Color kColorBlack = Color(0xff000000);
  static const Color kColorGrey = Color(0xff566470);
  static const Color kBorderColorGrey = Color(0xffCBD0D9);
  static const Color kBoxesColorGrey = Color(0xff3A3D45);
  static const Color kBottomNavBarBorderColorGrey = Color(0xff2F3336);
  static const Color kUnselectedTabLabelColorGrey = Color(0xff72767A);
  static const Color kPlaceholderProfileImageBackgroundColorGrey =
      Color(0xffE4E4E4);

  static const Color kUsernameColorGrey = Color(0xff6E767D);
}

final kTitleTextStyle = TextStyle(
  fontSize: 20.sp,
  fontFamily: GoogleFonts.inter().fontFamily,
  color: AppColor.kColorOffWhite,
  fontWeight: FontWeight.w900,
);

final kBackButtonTextStyle = TextStyle(
  fontSize: 12.sp,
  color: AppColor.kColorOffWhite,
  fontWeight: FontWeight.normal,
  fontFamily: GoogleFonts.inter().fontFamily,
);
