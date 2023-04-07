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
        textTheme: GoogleFonts.itimTextTheme(),
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
          // brightness : Text 색깔을 dark 모드일때 white로 해줌.
          // textTheme으로 정해도 개별 화면의 Text에는 별도의 textStyle을 또 정해줄 수도 있음.

          textTheme: GoogleFonts.itimTextTheme(
            ThemeData(brightness: Brightness.dark).textTheme,
          ),
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
 
