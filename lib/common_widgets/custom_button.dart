import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class CustomButton extends StatefulWidget {
  final Function() onPressed;
  final String text;
  final bool showIcon;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.showIcon = true,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool onclicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.5.h,
      width: 46.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.kDarkBlueColor,
        boxShadow: [
          onclicked == false
              ? BoxShadow(
                  color: AppColor.kDarkBlueColor.withOpacity(0.75),
                  blurRadius: 40,
                  spreadRadius: 10)
              : const BoxShadow(color: Colors.white30),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          widget.onPressed();
          onclicked = !onclicked;
          setState(() {});
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              widget.text,
              style: GoogleFonts.dmSans().copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.sp,
                  color: AppColor.kColorWhite),
            ),
            widget.showIcon
                ? const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColor.kColorWhite,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
