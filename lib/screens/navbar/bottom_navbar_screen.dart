import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';
import 'package:twitter_gpt/screens/homepage/homepage.dart';
import 'package:twitter_gpt/screens/reply/reply_screen.dart';
import 'package:twitter_gpt/utils/asset_constants.dart';
import 'package:twitter_gpt/utils/theme_constants.dart';

class BottomNavBarScreen extends StatefulWidget {
  static const routeName = '/bottom-nav-bar';
  const BottomNavBarScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const BottomNavBarScreen(),
    );
  }

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ReplyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          height: 8.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.kColorBlack,
            border: Border(
              top: BorderSide(color: AppColor.kColorGrey, width: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                icon: Image.asset(_selectedIndex == 0
                    ? homePageLogoSelected
                    : homePageLogoUnselected),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                icon: Image.asset(_selectedIndex == 1
                    ? replyPageLogoSelected
                    : replyPageLogoUnselected),
              ),
            ],
          ),
        ));
  }
}
