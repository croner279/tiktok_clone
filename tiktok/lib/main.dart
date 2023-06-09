import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok/common/widgets/main_navigation/widgets/darkMode_config.dart';
import 'package:tiktok/features/videos/repos/video_playback_config_repo.dart';
import 'package:tiktok/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok/firebase_options.dart';
import 'package:tiktok/router.dart';
import 'constants/sizes.dart';

void main() async {
  // 아래는 모든 Widget들이 engine과 연결된 것을 확실히 보장.
  // 그리고 다음 라인으로 무조건 세로화면으로 고정시켜버림
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        playbackConfigProvider
            .overrideWith(() => PlaybackConfigModelViewModel(repository))
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends ConsumerWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBuilder(
      animation: darkModeConfig,
      builder: (context, child) => MaterialApp.router(
        routerConfig: ref.watch(routerProvider),
        debugShowCheckedModeBanner: false,
        title: 'TikTok clone',
        // themeMode: ThemeMode.system 이건 시스템 설정에 따른다는 코드.
        themeMode: darkModeConfig.value ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
            useMaterial3: true,
            textTheme: Typography.blackMountainView,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: const Color(0xFFE9435A),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFFE9435A),
            ),
            splashColor: Colors.transparent, //splashcolor를 사실상 꺼버림.
            //highlightColor: Colors.transparent 이건 클릭 효과를 꺼버림
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.size16 + Sizes.size2,
                  fontWeight: FontWeight.w600),
            ),
            tabBarTheme: TabBarTheme(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              indicatorColor: Colors.black,
            ),
            listTileTheme: const ListTileThemeData(
              iconColor: Colors.black,
            )),
        darkTheme: ThemeData(
          //useMaterial3 하는 순간 bottomAppBar 이런 위젯은 없어지기 때문에 Container 등으로 바꿔야 함
          useMaterial3: true,
          tabBarTheme: TabBarTheme(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade700,
          ),
          textTheme: Typography.whiteMountainView,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade800,
          ),
          appBarTheme: AppBarTheme(
              centerTitle: true,
              surfaceTintColor: Colors.grey.shade900,
              backgroundColor: Colors.grey.shade900,
              elevation: 0,
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size16 + Sizes.size2,
                  fontWeight: FontWeight.w600),
              actionsIconTheme: IconThemeData(
                color: Colors.amber.shade400,
              ),
              iconTheme: IconThemeData(
                color: Colors.grey.shade100,
              )),
        ),
        //이제 아래가 home임. home 프로퍼티를 지정안하면 에러가 나서 이니셜라우트 해줘야 함.
      ),
    );
  }
}


//Dark Mode 방법1. Theme의 모든 디폴트 컬러, background 등 전부 설정해줌.
//          방법2. 기존 코드 중에 이미 하드 코딩 된 색깔 (회색 같은)이 있다면, MediaQuery 사용