import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/inbox/activity_screen.dart';
import 'package:tiktok/features/inbox/chats_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
//Stateless Widgete에서는 메소드가 자체적인 context를 가질 수 없다. Build 메소드만이 context를 가질 수 있다.
  void _onDmPressed() {
    context.pushNamed(ChatsScreen.routeName);
  }

  void _onActivityTap(BuildContext context) {
    context
        .pushNamed(ActivityScreen.routeName); // ctrl + spacebar 누르면 메소드 단축키 뜬다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Inbox'),
        actions: [
          IconButton(
            onPressed: _onDmPressed,
            icon: const FaIcon(
              FontAwesomeIcons.paperPlane,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            //여러 항목이 있는 list만들 때 꿀위젯임. 별의 별 메소드 있으니 보세요.
            onTap: () => _onActivityTap(context),
            title: const Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade300,
          ),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'New followers',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            subtitle: const Text(
              'Messages from followers will appear here',
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
