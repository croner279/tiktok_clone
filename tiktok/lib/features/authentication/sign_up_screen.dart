import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';
import 'package:tiktok/utils.dart';

class SignUpScreen extends StatelessWidget {
  //static 변수라 widget을 build해줄 필요가 없다.

  static const routeURL = "/";
  static const routeName = "signUp";
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    //go_router extension.dart 패키지에서 context 객체를 확장, push 메소드를 갖게 해줌.
    context.pushNamed(LoginScreen.routeName);
    //.push 로 page stack을 쌓고, .pop은 스택 중 젤 윗화면을 치워서 이전화면으로 가게 되는데, .go는 stack과는 별도의 공간으로 보내버림.
    //그래서 .push와 다르게 .go로 이동하면 back 버튼을 제공 안해줌. 웹이라면 뒤로가기 버튼이 있는데, 앱은 그게 없음.
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UsernameScreen(),
        ));
  }

  //Dart는 다른 언어의 public, private, protected 같은 접근 지정자가 없어서 메서드를 private으로 선언하려면
  // 그냥 메서드나 프로퍼티 앞에 _를 붙여줘라.

/*     Navigator.of(context).push(
      PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const UsernameScreen(),
          //transitionBuilder의 child는 pageBuilder가 호출하는 그 무엇
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation);
            final opacityAnimation = Tween(
              begin: 0.5,
              end: 0.8,
            ).animate(animation);
            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          }),
    ); */

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size40,
            ),
            child: Column(
              children: [
                Gaps.v80,
                const Text("Sign up for WoolTok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    )),
                Gaps.v20,
                const Opacity(
                  opacity: 0.7,
                  // opacity 위젯을 통해서...  모드 별 70% 흰색, 검정색 만들기 가능
                  child: Text(
                    "Create a profile, follow other accounts, make your own videos and more.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      /*   color: isDarkmode(context)
                          ? Colors.grey.shade400
                          : Colors.black45, */
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v40,
                //collection if, collection for는 하나의 대상에만 작동. 즉, 하나의 AuthButton에만 적용 된다.
                //if 다음 덩어리는 list로 묶고 '...' 을 붙여주면, Collection if가 list를 return 함.
                if (orientation == Orientation.portrait) ...[
                  GestureDetector(
                    onTap: () => _onEmailTap(context),
                    child: const AuthButton(
                        icon: FaIcon(FontAwesomeIcons.user),
                        text: "Use email & password"),
                  ),
                  Gaps.v16,
                  const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.apple),
                      text: "Continue with Apple")
                ],

                //기존 Code에서 지금 Row는 고정된 크기를 제공하고 있지 않아서 문제 발생. auth_Button에서는 FractionallySizedBox라서 부모의 고정된 크기가 필요함.
                // FractionallySizedBox가 Row 안에 있을 때는, FractionallySizedBox의 상위 위젯(이 경우 GestureDetector)을 expanded로 감싸준다.
                if (orientation == Orientation.landscape)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _onEmailTap(context),
                          child: const AuthButton(
                              icon: FaIcon(FontAwesomeIcons.user),
                              text: "Use email & password"),
                        ),
                      ),
                      Gaps.h16,
                      const Expanded(
                        child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.apple),
                            text: "Continue with Apple"),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: isDarkmode(context) ? null : Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.only(
              top: Sizes.size32,
              bottom: Sizes.size32,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
