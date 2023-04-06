import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/features/main_navigation/main_navigation.dart';

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
/* 
class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        //Layoutbuilder가 Scaffold body 바로 아래 있을 때는 화면 제약이 없음. 화면최대크기가 constraints.max가 됨
        //LayoutBuilder는 결국 부모 위젯의 최대크기를 알고 싶을 때 사용하는 것임.
        body: SizedBox(
      width: size.width / 2,
      child: LayoutBuilder(
          builder: (context, constraints) => Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.amber,
                child: Center(
                  child: Text(
                    "${size.width}/${constraints.maxWidth}",
                    style: const TextStyle(color: Colors.white, fontSize: 56),
                  ),
                ),
              )),
    ));
  }
}
 */