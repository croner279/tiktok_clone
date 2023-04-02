import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  // Ticker는 모든 애니메이션 프레임에서 Callback Function을 호출하는 시계임. SingleTickerMixin은 Ticker뿐만 아니라, 위젯이
  // Widget tree에 없을 때 리소스 낭비 하지 않도록 막아줌.
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  //this나 다른 instance member를 참조하려면 late을 사용해야 만 함. 그리고 위처럼 코드 작성 시 initState가 필요 없음.

  late final Animation<double> _animation = Tween(
    begin:
        0.0, //이건 turns임. RotationTransition turn 해야 되는데 어디까지? end 1.0은 1 turn 회전하라는 것임.
    end: 0.5,
  ).animate(_animationController);
// 지난번에는 1. AnimationController의 value를 수정하고 Controller에 event Listner를 추가. 그리고 setState하면 그게 build메소드 실행시키고 사용자에게 애니메이션의 각 단계를 보여줌
// 2. Animation Builder 사용하기.
// 그러나 이번에는 setState, Animation Builder 어떤 걸 사용하지 않아도 됨. animation Controller랑 animation <double> 리스트만 있으면 됨

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  void _onTitleTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
      // 위 두개 코드 없으면, All Acitivty 한번밖에 못돌림.
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All Activity"),
              Gaps.h6,
              RotationTransition(
                turns: _animation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Gaps.v14,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            child: Text(
              'New',
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Gaps.v14,
          for (var notifications in _notifications)
            Dismissible(
              //Dismissible은 자식 위젯을 왼쪽 오른쪽 드래그로 밀어버릴 수 있음.
              key: Key(notifications),
              onDismissed: (direction) => _onDismissed(notifications),
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.green,
                child: const Padding(
                  padding: EdgeInsets.only(left: Sizes.size10),
                  child: FaIcon(
                    FontAwesomeIcons.checkDouble,
                    color: Colors.white,
                    size: Sizes.size32,
                  ),
                ),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.only(left: Sizes.size10),
                  child: FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.white,
                    size: Sizes.size32,
                  ),
                ),
              ),
              child: ListTile(
                minVerticalPadding: Sizes.size16,
                // contentPadding: EdgeInsets.zero,
                //ListTile의 자체적인 padding이 있어서 이걸 없애줘야 New와 같은 라인에 붙음
                leading: Container(
                  width: Sizes.size52,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: Sizes.size1,
                      )),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.bell,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: RichText(
                  //text마다 스타일을 다르게 적용 가능
                  text: TextSpan(
                      text: "Account updates : ",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: Sizes.size16,
                      ),
                      children: [
                        const TextSpan(
                          text: "Upload longer videos",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: notifications,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ]),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
