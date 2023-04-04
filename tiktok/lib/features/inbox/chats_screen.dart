import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  final Duration _duration = const Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(_items.length,
          duration: const Duration(
              milliseconds: 500)); //currentState가 null 이 아니므로  을 넣어준다.
      _items.add(_items.length);
    }
  }

// _addItem에서 아이템을 새로 생성하면 AnimatedList 위젯은 Itembuilder 함수를 실행, 아이템을 렌더링.

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index, // View로부터 아이템 삭제할 때 우리가 보여주고 싶은 아이템을 반환해야 함
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Colors.red,
            child: _makeTile(index),
          ), // 왜 이렇게 했냐면, 메시지가 삭제되는 애니메이션에도, 그 메세지 UI가 그대로 지워지는 모습을 구현하기 위해서임.
        ),
        duration: _duration,
      );
      _items.removeAt(index);
    }
  }

  void _onChatTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ChatDetailScreen(),
    ));
  }

  Widget _makeTile(int index) {
    return ListTile(
      onTap: _onChatTap,
      onLongPress: () => _deleteItem(index),
/* 코드에서 onLongPress 속성은 길게 누르면 실행되는 콜백 함수를 지정하는 역할을 합니다. 예를 들어, 버튼을 길게 누르면 버튼을 클릭한 것과는 다른 동작을 수행할 수 있습니다.
그런데 코드에서는 onLongPress 속성에 _deleteItem(index)를 직접 전달하고 있습니다. 이렇게 하면 아이템이 추가될 때 _deleteItem 함수가 즉시 실행됩니다. 즉, onLongPress가 아닌, AnimatedList 위젯이 초기화될 때마다 _deleteItem 함수가 실행됩니다.
그래서 코드를 수정해서 onLongPress 속성에 콜백 함수를 전달하도록 해야 합니다. 콜백 함수는 onLongPress 속성에 지정한 함수를 실행시키는 역할을 합니다. 이렇게 하면 버튼을 길게 눌렀을 때만 _deleteItem 함수가 실행됩니다.
위에서 제시한 수정된 코드에서는 _deleteItem(index) 대신에 () => _deleteItem(index)를 전달하고 있습니다. 이렇게 하면 버튼을 길게 눌렀을 때 _deleteItem 함수가 실행됩니다. */

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
    );
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
            child:
                SizeTransition(sizeFactor: animation, child: _makeTile(index)),
          );
        },
      ),
    );
  }
}
