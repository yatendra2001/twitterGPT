import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class WriteTweetScreen extends StatefulWidget {
  static const routeName = '/write-tweet-screen';
  const WriteTweetScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const WriteTweetScreen(),
    );
  }

  @override
  State<WriteTweetScreen> createState() => _WriteTweetScreenState();
}

class _WriteTweetScreenState extends State<WriteTweetScreen> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      child: Text("Cancel",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColor.kColorWhite)),
                      onPressed: () => Navigator.of(context).pop()),
                  CustomButton(
                    height: 5.h,
                    width: 45.w,
                    padding: 0,
                    onPressed: isEmpty ? null : () {},
                    text: "Tweet",
                    isColorGreen: true,
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 14.w,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundColor: AppColor
                            .kPlaceholderProfileImageBackgroundColorGrey,
                        child: SessionHelper.profileImageUrl == null
                            ? null
                            : CachedNetworkImage(
                                imageUrl: SessionHelper.profileImageUrl!),
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
                        value.length > 0 ? isEmpty = false : isEmpty = true;
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
                          hintText: 'Write the tweet here.',
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
