import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/models/tweet_model.dart';
import 'package:twitter_gpt/repositories/appwrite_repo/appwrite_repo.dart';
import 'package:twitter_gpt/repositories/tweets/tweet_repo.dart';
import 'package:twitter_gpt/screens/widgets/custom_button.dart';
import 'package:twitter_gpt/utils/session_helper.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class WriteTweetScreen extends StatefulWidget {
  static const routeName = '/write-tweet-screen';
  const WriteTweetScreen({super.key});
  static Route route() {
    return PageTransition(
        settings: const RouteSettings(name: routeName),
        child: const WriteTweetScreen(),
        type: PageTransitionType.bottomToTop);
  }

  @override
  State<WriteTweetScreen> createState() => _WriteTweetScreenState();
}

class _WriteTweetScreenState extends State<WriteTweetScreen> {
  final TextEditingController _textEditingController =
      TextEditingController(text: SessionHelper.tweet);
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool isEmpty = SessionHelper.tweet?.isEmpty == null ? true : false;

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

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
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CustomButton(
                      height: 5.h,
                      width: 35.w,
                      padding: 0,
                      onPressed: isEmpty
                          ? null
                          : () async {
                              String? fileId;
                              try {
                                if (_image != null) {
                                  fileId = await AppwriteRepo()
                                      .uploadDataToStorageBucket(
                                          image: InputFile.fromPath(
                                              path: _image!.path));
                                }
                                await TweetRepo().postTweet(
                                    tweetText: _textEditingController.text,
                                    tweetMediaID: fileId ?? "");
                                await AppwriteRepo()
                                    .addTweetDataToUserCollection(
                                        tweet: TweetModel(
                                            uid: SessionHelper.uid,
                                            text: SessionHelper.tweet,
                                            fileId: fileId ?? "",
                                            prompt: SessionHelper.prompt));
                                ScaffoldMessenger(
                                    child: Text(
                                  "Tweeted Successfully",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColor.kColorWhite),
                                ));
                                Navigator.of(context).pop();
                              } catch (error) {
                                debugPrint(error.toString());
                              }
                            },
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
                          child: SessionHelper.user?.profileImageUrl == null
                              ? null
                              : CachedNetworkImage(
                                  imageUrl:
                                      SessionHelper.user!.profileImageUrl!),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    SizedBox(
                      height: 40.h,
                      width: 74.w,
                      child: TextField(
                        autofocus: true,
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
                            hintText: 'Write the tweet here.',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColor.kColorGrey)),
                      ),
                    ),
                  ],
                ),
                if (_image != null) Image.file(File(_image!.path)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.photo),
                    color: AppColor.kGreenColor,
                    onPressed: pickImage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
