import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';
import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class ReplyPage extends StatefulWidget {
  const ReplyPage({super.key});

  @override
  State<ReplyPage> createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomButton(
                height: 5.h,
                width: 45.w,
                padding: 0,
                onPressed: isEmpty ? null : () {},
                text: "Generate replies",
                isColorGreen: true,
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 14.w,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        twitterGPTLogoGreen,
                        scale: 10.5,
                        filterQuality: FilterQuality.low,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  SizedBox(
                    height: 40.h,
                    width: 74.w,
                    child: TextField(
                      cursorColor: AppColor.kColorGrey,
                      controller: _textEditingController,
                      onChanged: (value) => setState(() {
                        value.isNotEmpty ? isEmpty = false : isEmpty = true;
                      }),
                      keyboardType: TextInputType.multiline,
                      minLines: 10,
                      maxLines: 20,
                      maxLength: 250,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColor.kColorWhite,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Paste the text of original tweet here.',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColor.kColorGrey)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
