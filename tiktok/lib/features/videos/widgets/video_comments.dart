import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            child: const Text('Im a comments'),
          ),
        ),
      ),
    );
  }
}
