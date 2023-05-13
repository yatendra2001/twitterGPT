import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CustomDotIndicator extends StatelessWidget {
  final double curPageIndex;
  final Function(int) onTap;

  const CustomDotIndicator({
    Key? key,
    required this.curPageIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: 4,
      position: curPageIndex.toInt(),
      onTap: onTap,
      decorator: DotsDecorator(
        spacing: EdgeInsets.all(8),
        size: const Size.fromRadius(6),
        activeSize: const Size(25.0, 9.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: const Color(0XFFE0E5F2),
        activeColor: const Color(0XFF4318FF),
      ),
    );
  }
}
