import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/discover/discover_screen.dart';
import 'package:tiktok/features/inbox/inbox_screen.dart';
import 'package:tiktok/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok/features/users/user_profile_screen.dart';
import 'package:tiktok/features/videos/video_recording_screen.dart';
import 'package:tiktok/features/videos/video_timeline_screen.dart';
import 'package:tiktok/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);
//Web에서 실행할 때는 브라우저 정책상 소리가 있는 영상을 자동적으로 실행시키지 못하게 함.
//영상 재생 남용을 막기 위함임.

//Web에서 실행하는 법 : launch.json 설정 바꿔주면 됨.
//https://sudarlife.tistory.com/entry/flutter-web-%ED%94%8C%EB%9F%AC%ED%84%B0-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%EB%A5%BC-%EC%9B%B9%EA%B3%BC-%EC%95%A0%EB%AE%AC%EB%A0%88%EC%9D%B4%ED%84%B0%EB%A1%9C-%EB%8F%8C%EB%A0%A4%EB%B3%B4%EC%9E%90-vscode-%EC%84%B8%ED%8C%85%EB%B2%95
  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkmode(context);
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //comment 창에서 키보드를 열어도 영상이 찌그러지지 않게(Scaffold가 body 크기를 자동으로 조정) false로 고정시켜줌
      backgroundColor:
          _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(children: [
        Offstage(
          offstage: _selectedIndex != 0, //첫번째 화면은 selectedIndex가 0이 아닐 때 숨겨짐.
          child: const VideoTimelineScreen(),
        ),
        Offstage(
          offstage: _selectedIndex != 1,
          child: const DiscoverScreen(),
        ),
        Offstage(
          offstage: _selectedIndex != 3,
          child: const InboxScreen(),
        ),
        Offstage(
          offstage: _selectedIndex != 4,
          child: const UserProfileScreen(
            username: "울쨩이",
            tab: "",
          ),
        ),
      ]), //screens[_selectedIndex]랑 동일함
      bottomNavigationBar: Container(
        color: _selectedIndex == 0 || isDarkmode(context)
            ? Colors.black
            : Colors.white,
        child: Padding(
            padding: const EdgeInsets.only(
              top: Sizes.size12,
              bottom: Sizes.size12,
              left: Sizes.size24,
              right: Sizes.size24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavTab(
                    text: "Home",
                    isSelected: _selectedIndex == 0,
                    icon: FontAwesomeIcons.house,
                    selectedIcon: FontAwesomeIcons.house,
                    onTap: () => _onTap(0),
                    selectedIndex: _selectedIndex),
                NavTab(
                    text: "Discover",
                    isSelected: _selectedIndex == 1,
                    icon: FontAwesomeIcons.compass,
                    selectedIcon: FontAwesomeIcons.solidCompass,
                    onTap: () => _onTap(1),
                    selectedIndex: _selectedIndex),
                Gaps.h24,
                GestureDetector(
                  onTap: _onPostVideoButtonTap,
                  child: PostVideoButton(inverted: _selectedIndex != 0),
                ), //UI는 Post_video_button.dart에서 하고, 여기서는 동작을 짜자.
                Gaps.h24,
                NavTab(
                    text: "Inbox",
                    isSelected: _selectedIndex == 3,
                    icon: FontAwesomeIcons.message,
                    selectedIcon: FontAwesomeIcons.solidMessage,
                    onTap: () => _onTap(3),
                    selectedIndex: _selectedIndex),
                NavTab(
                    text: "Profile",
                    isSelected: _selectedIndex == 4,
                    icon: FontAwesomeIcons.user,
                    selectedIcon: FontAwesomeIcons.solidUser,
                    onTap: () => _onTap(4),
                    selectedIndex: _selectedIndex),
              ],
            )),
      ),
    );
  }
}
