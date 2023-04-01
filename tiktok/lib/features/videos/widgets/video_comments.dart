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
  bool _isWriting = false;

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOfComment = MediaQuery.of(context).size;
    return Container(
      height: sizeOfComment.height * 0.7,
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
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                  horizontal: Sizes.size16,
                ),
                separatorBuilder: (context, index) => Gaps
                    .v20, //.separated 메소드를 통해 항목 사이에 구분선 추가 가능. separatorBuilder 속성 사용해서 구분 선 그리는 위젯 지정 가능.
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
              Positioned(
                //왜 bottomNavigation 안쓰냐면.. 기본적으로 키보드를 열면 bottomAppbar가 숨겨지거든. 근데 우리는 키보드랑 같이 딸려올라가길 바람. 그래서 Stack으로 Listview를 다시 감싼 다음, Positioned 내에 넣음.
                bottom: 0,
                width: sizeOfComment.width,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                      vertical: Sizes.size10,
                    ),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade500,
                        foregroundColor: Colors.white,
                        child: const Text('용쨩'),
                      ),
                      Gaps.h10,
                      Expanded(
                          child: //Expanded 내에 TextField를 넣지 않으면, TextField의 width가 unbounded 되어서 좋지 않다는 오류 창 발생!
                              //게다가, 키보드를 열면 main_navigation screen에서 flutter은 body 크기를 조정(키보드에 가려지지 않도록), 영상 화면이 찌그러짐.
                              SizedBox(
                        height: Sizes.size44,
                        child: TextField(
                          onTap: _onStartWriting,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            hintText: "Write a comment...",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                                borderSide: BorderSide
                                    .none //이거 안없애면 input box 클릭 시 못생긴 파란색 테두리가 생긴다.
                                ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                              vertical: Sizes.size12,
                            ),
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(right: Sizes.size14),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.at,
                                    color: Colors.grey.shade900,
                                  ),
                                  Gaps.h8,
                                  FaIcon(
                                    FontAwesomeIcons.gift,
                                    color: Colors.grey.shade900,
                                  ),
                                  Gaps.h8,
                                  FaIcon(
                                    FontAwesomeIcons.faceSmile,
                                    color: Colors.grey.shade900,
                                  ),
                                  Gaps.h8,
                                  if (_isWriting)
                                    GestureDetector(
                                      onTap: _stopWriting,
                                      child: FaIcon(
                                        FontAwesomeIcons.circleArrowUp,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
