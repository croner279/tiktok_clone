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
      // 빈화면에서는 length가 0이기 때문에, 0부터 넣으면서 시작한다. 0 넣어지면서 채팅창 하나 뜨는 것임
    }
  }
/* 
Q. _key.currentState != null 어떨 때 null임?
A. _key.currentState이 null이 될 가능성이 있는 경우는 AnimatedList 위젯이 아직 초기화되지 않은 경우입니다. 
예를 들어, _key.currentState을 호출하기 전에 initState() 메서드에서 AnimatedList 위젯을 초기화하지 않았을 수 있습니다.
 또는 AnimatedList 위젯을 initState() 메서드에서 초기화하지 않고,  이전 화면에서 이동했을 때 AnimatedList 위젯의 상태를 보존하려고 할 때도 _key.currentState이 null이 될 수 있습니다. **
 따라서 _key.currentState이 null이 아닌지 항상 확인하는 것이 좋습니다.
 */
/* 
Flutter에서 페이지 전환 시, 이전 화면의 위젯 상태를 보존하거나 새로운 위젯을 생성하여 표시하는 방법이 있습니다. 이전 화면에서 이동한 화면으로 돌아갈 때, 이전 화면의 위젯 상태를 그대로 가져오려면 이전 화면의 위젯 상태를 보존해야 합니다.

AnimatedList 위젯은 이전 화면에서 이동한 화면으로 돌아갈 때, 이전 화면의 위젯 상태를 보존할 수 있도록 지원합니다. 이를 위해, AnimatedList 위젯은 GlobalKey를 사용하여 현재 위젯의 상태를 기록하고 이전 화면으로 돌아올 때 기록된 상태를 사용하여 이전 상태를 보존합니다. 그러나 이전 화면에서 이동한 화면으로 돌아갈 때, 초기화가 이루어지지 않은 AnimatedList 위젯의 상태를 보존하려고 할 때도 있습니다. 이러한 경우, _key.currentState은 null일 수 있습니다.

따라서, 초기화되지 않은 AnimatedList 위젯의 상태를 보존하기 위해서는 initState() 메서드에서 AnimatedList 위젯을 초기화하고, GlobalKey를 사용하여 현재 상태를 기록해야 합니다. 이렇게 하면 이전 화면에서 이동한 화면으로 돌아갈 때, 이전 상태를 보존할 수 있습니다.



 */

// _addItem에서 아이템을 새로 생성하면 AnimatedList 위젯은 Itembuilder 함수를 실행, 아이템을 렌더링.

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        // View로부터 아이템 삭제할 때 우리가 보여주고 싶은 아이템을 반환해야 함
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

/* 
Q. void _deleteItem 함수에서 .removeItem 외에도 .removeAt이 필요한 이유는?
A._deleteItem 함수에서 removeItem 메소드는 AnimatedList에서 특정 항목을 제거하는 메소드입니다. 
하지만, 이 메소드는 AnimatedList 위젯에서 삭제할 항목을 반환해야 합니다. 따라서 AnimatedList 위젯에서 _makeTile 함수를 호출하여 해당 위치에 대한 ListTile 위젯을 가져와야 합니다.
removeAt 메소드는 그 자체로 항목을 삭제하지만, deleteItem 함수에서는 동시에 items 배열에서도 해당 항목을 삭제해야 합니다. 
따라서, removeItem 메소드를 사용하여 AnimatedList 위젯에서 해당 항목을 제거하고, items 배열에서 removeAt 메소드를 사용하여 해당 항목을 제거합니다.
 */

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
