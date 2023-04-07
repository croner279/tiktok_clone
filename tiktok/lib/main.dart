import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';

import 'constants/sizes.dart';

void main() async {
  // 아래는 모든 Widget들이 engine과 연결된 것을 확실히 보장.
  // 그리고 다음 라인으로 무조건 세로화면으로 고정시켜버림
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok clone',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        //brightness : Text 색깔을 light 모드일때 black으로 해줌.
        //왠만하면 앱 만들기 전에 ThemeData 다 정해놓고 짜라
        brightness: Brightness.light,
        textTheme: TextTheme(
          //material 공홈의 typography 부분
          displayLarge: GoogleFonts.openSans(
              fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          displayMedium: GoogleFonts.openSans(
              fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          displaySmall:
              GoogleFonts.openSans(fontSize: 47, fontWeight: FontWeight.w400),
          headlineMedium: GoogleFonts.openSans(
              fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headlineSmall:
              GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w400),
          titleLarge: GoogleFonts.openSans(
              fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          titleMedium: GoogleFonts.openSans(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          titleSmall: GoogleFonts.openSans(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyLarge: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyMedium: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          labelLarge: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          bodySmall: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          labelSmall: GoogleFonts.roboto(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),

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
      darkTheme: ThemeData(
          //brightness : Text 색깔을 dark 모드일때 white로 해줌.
          textTheme: const TextTheme(
              //이런 식으로 textTheme을 미리 정해두면 다른 화면에서도 일괄적으로 통일 가능
              headlineLarge: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          )),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFE9435A),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade800,
          )),
      home: const SignUpScreen(),
    );
  }
}


//Dark Mode 방법1. Theme의 모든 디폴트 컬러, background 등 전부 설정해줌.
//          방법2. 기존 코드 중에 이미 하드 코딩 된 색깔 (회색 같은)이 있다면, MediaQuery 사용
 
