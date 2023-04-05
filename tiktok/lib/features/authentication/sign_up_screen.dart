import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      //이렇게 push를 하면 화면을 기존 화면 위에 쌓는 것임.
      // Sign up 누르면 Sign up 화면 뜨고 거기서 Log in 누르면 그 위에 Log in 화면 덮어지고 팬케이크 쌓듯이 무한반복
      // 그래서 어느 지점에서는 멈춰야됨. loginscreen 에서는 push가 아니라 뒤로가기를 하는 것.
      builder: (context) => const LoginScreen(),
    ));
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  } //Dart는 다른 언어의 public, private, protected 같은 접근 지정자가 없어서 메서드를 private으로 선언하려면
  // 그냥 메서드나 프로퍼티 앞에 _를 붙여줘라.

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
                const Text(
                  "Sign up for WoolTok",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v20,
                const Text(
                  "Create a profile, follow other accounts, make your own videos and more.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
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
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade50,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size32,
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
