import 'package:flutter/material.dart';
import 'package:tiktok/features/main_navigation/main_navigation.dart';

import 'constants/sizes.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        splashColor: Colors.transparent, //splashcolor를 사실상 꺼버림.
        //highlightColor: Colors.transparent 이건 클릭 효과를 꺼버림
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size16 + Sizes.size2,
                fontWeight: FontWeight.w600)),
      ),
      home: const MainNavigationScreen(),
    );
  }
}
