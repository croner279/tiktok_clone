import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(_items.length,
          duration: const Duration(
              milliseconds: 500)); //currentState가 null 이 아니므로  을 넣어준다.
      _items.add(_items.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Direct messages'),
        actions: [
          IconButton(
              onPressed: _addItem, icon: const FaIcon(FontAwesomeIcons.plus))
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        itemBuilder: // 아이템 빌더만 있고 아이템 추가하지 않아서 화면에는 아무것도 안나옴.
            (BuildContext context, int index, Animation<double> animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 20,
                  child: Text('울쨩'),
                  // foregroundImage: NetworkImage(url),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "용쨩 ($index)",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "2:16 PM",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: Sizes.size14,
                      ),
                    )
                  ],
                ),
                subtitle: const Text('Minds Open, Eyes Open!'),
                //          trailing: Text("2:16 PM",
                //            style: TextStyle(
                //              color: Colors.grey.shade500, fontSize: Sizes.size14)),
              ),
            ),
          );
        },
      ),
    );
  }
}
