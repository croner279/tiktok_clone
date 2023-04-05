import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListWheelScrollView(
          itemExtent: 100,
          diameterRatio: 1,
          offAxisFraction: 1,
          children: [
            for (var x in [1, 2, 2, 3, 4, 3, 23, 23, 3, 3])
              FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                    color: Colors.teal,
                    alignment: Alignment.center,
                    child: const Text('Pick Me')),
              )
          ],
        ));
  }
}

// Closebutton - X자 표시
//CupertinoActivityIndicator - iOS 로딩 아이콘
//CircularProgressIndicator - Material 로딩 아이콘
//CircularProgressIndicator.adaptive() - 각자 모바일 환경에 맞는 로딩 아이콘 보여줌
