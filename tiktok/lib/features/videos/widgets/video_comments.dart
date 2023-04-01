import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip
          .hardEdge, //clipBehavior 속성은 해당 위젯의 자식 요소(Scaffold)가 위젯 경계를 벗어날 때 어떻게 처리하는 지 사용.
      // clip.hardedge는 경계의 가장자리에서 잘라내기(Clip)하고 남은 부분은 그대로 표시.
      // 그니깐, Container는 모서리 잘라내기를 했는데 Scaffold는 그대로니깐 결과적으로는 사각형 모달창이 보이는 거거든. 그래서 hardedge 해버리면 scaffold 테두리도 깎아버리는 것임.
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
        Sizes.size16,
      )),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text(
              '22796 comments'), //back button이 뜨는데 그건 새 화면으로 push(naviagate)했기 떄문. 보기 싫으니 없애자.
          actions: [
            IconButton(
                onPressed: _onClosePressed,
                icon: const FaIcon(FontAwesomeIcons.xmark))
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size16,
          ),
          separatorBuilder: (context, index) => Gaps.v20,
          itemCount: 10,
          itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                child: Text('용쨩'),
              ),
              Gaps.h16,
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '용쨩',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size14,
                        color: Colors.grey,
                      ),
                    ),
                    Gaps.v4,
                    Text('♡ㅁ♥')
                  ],
                ),
              ),
              Gaps.h10,
              Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.heart,
                    color: Colors.grey.shade500,
                    size: Sizes.size20,
                  ),
                  Gaps.v2,
                  Text(
                    '52.2K',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade500,
              foregroundColor: Colors.white,
              child: const Text('용쨩'),
            )
          ]),
        ),
      ),
    );
  }
}
