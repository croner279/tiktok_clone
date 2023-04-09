import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";
  //자식 경로(Goroute 내에서 세부 router로 가는 것)는 "/"로 시작할 수 없어서 세미콜론으로 시작하게 함.

  final String chatID;

  const ChatDetailScreen({
    super.key,
    required this.chatID,
  });
  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 10,
          leading: const CircleAvatar(
            radius: Sizes.size20,
            //foregroundColor: ,
            child: Text('울쨩'),
          ),
          title: Text(
            '울쨩 (${widget.chatID})',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: const Text('Active Now'),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h24,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ], //ctrl+alt 누르면 required가 동시에 나타남.
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Sizes.size14),
                      decoration: BoxDecoration(
                          color: isMine
                              ? Colors.blue
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(
                                  isMine ? Sizes.size20 : Sizes.size5),
                              bottomRight: Radius.circular(
                                  isMine ? Sizes.size5 : Sizes.size20))),
                      child: const Text(
                        'This is a message!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size14,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).primaryColor,
                        autocorrect: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Send a Message..",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.size16,
                              ),
                              borderSide: BorderSide.none),
                          suffixIcon: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.faceLaugh,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Gaps.h16,
                    Container(
                      padding: const EdgeInsets.all(Sizes.size8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: const FaIcon(FontAwesomeIcons.solidPaperPlane),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
/* 
이 코드에서 Stack 위젯은 화면을 겹치는 레이아웃을 구현하기 위해 사용되었습니다. 
Column 대신 Stack을 사용한 이유는 Column을 사용하면 화면의 위쪽에 ListView 위젯을 두고 아래쪽에 TextField와 Send 버튼을 배치해야 합니다. 그러나 이렇게 하면 TextField와 Send 버튼이 ListView 위젯을 가리게 되므로, 이를 해결하기 위해 Stack 위젯을 사용하여 화면을 겹치는 방식으로 구현합니다.
Stack 위젯은 여러 개의 위젯을 겹쳐서 표시할 수 있는 위젯입니다.
이 코드에서는 ListView 위젯과 BottomAppBar 위젯을 Stack 위젯으로 겹쳐서 표시합니다. 
이렇게 하면 화면의 아래쪽에 TextField와 Send 버튼을 배치할 수 있으며, ListView 위젯이 가리지 않도록 
BottomAppBar 위젯이 ListView 위젯을 덮게 됩니다.
따라서, Stack 위젯을 사용하여 ListView 위젯과 BottomAppBar 
위젯을 겹치는 레이아웃을 구현한 것입니다.


 */

  