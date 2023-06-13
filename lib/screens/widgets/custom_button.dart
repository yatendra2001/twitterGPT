import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Image? icon;
  final VoidCallback? onPressed;
  final String text;
  final bool? isColorGreen;
  final double? padding;
  const CustomButton({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.text,
    this.icon,
    this.isColorGreen,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: icon != null
          ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.kColorWhite,
                padding: EdgeInsets.symmetric(
                    horizontal: padding == null ? 10.w : padding!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: icon!,
              label: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColor.kColorBlack, fontWeight: FontWeight.w600),
              ),
              onPressed: onPressed,
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isColorGreen == null
                    ? AppColor.kColorWhite
                    : AppColor.kGreenColor,
                padding: EdgeInsets.symmetric(
                    horizontal: padding == null ? 10.w : padding!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: isColorGreen == null
                        ? AppColor.kColorBlack
                        : AppColor.kColorWhite,
                    fontWeight: FontWeight.w600),
              ),
            ),
    );
  }
}
