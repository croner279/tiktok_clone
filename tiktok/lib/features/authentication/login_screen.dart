import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void onSignUpTap(BuildContext context) {
    Navigator.of(context).pop();
    // Naivgator의 가장 상단 화면, 유저가 현재 보고 있는 현재 화면을 스택에서 제거해줌.
    // 스택에는 push 와 pop이 있는데, push는 기존 팬케잌 위에 새 팬케잌을 두는 것. (팬케잌=화면)
    // pop 은 제일 위에 있는 팬케잌을 빼는 것
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                "Log in to WoolTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Text(
                "Manage your account, check notification, comment on videos, and more.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size32,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              Gaps.h5,
              GestureDetector(
                onTap: () => onSignUpTap(context),
                child: Text(
                  "Sign up",
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
  }
}
