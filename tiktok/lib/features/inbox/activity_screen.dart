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

  final List<Map<String, dynamic>> _tabs = [
    {"title": "All activity", "icon": FontAwesomeIcons.solidMessage},
    {"title": "Likes", "icon": FontAwesomeIcons.solidHeart},
    {"title": "Comments", "icon": FontAwesomeIcons.solidComments},
    {"title": "Mentions", "icon": FontAwesomeIcons.at},
    {"title": "Followers", "icon": FontAwesomeIcons.solidUser},
    {"title": "From TikTok", "icon": FontAwesomeIcons.tiktok}
  ];

  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  //this나 다른 instance member를 참조하려면 late을 사용해야 만 함. 그리고 위처럼 코드 작성 시 initState가 필요 없음.

  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0, end: 0.5,
    //이건 turns임. RotationTransition turn 해야 되는데 어디까지? end 1.0은 1 turn 회전하라는 것임.
  ).animate(_animationController);
// 지난번에는 1. AnimationController의 value를 수정하고 Controller에 event Listner를 추가. 그리고 setState하면 그게 build메소드 실행시키고 사용자에게 애니메이션의 각 단계를 보여줌
// 2. Animation Builder 사용하기.
// 그러나 이번에는 setState, Animation Builder 어떤 걸 사용하지 않아도 됨. animation Controller랑 animation <double> 리스트만 있으면 됨

  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1),
    //(0, -0.5)라면 패널을 수직축으로 50%만큼 위로 옮기겠다는 뜻 0.5 는 절대 수치가 아니라 비율적인 거. ㅅ
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  void _toggleAnimation() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
      // 위 두개 코드 없으면, All Acitivty 한번밖에 못돌림.
    } else {
      _animationController.forward();
      //reverse, forward 모두 futre를 반환하는데 이건 애니메이션이 끝나야 완료됨.
      // 그래서 All activity 누르면 setState -> build 메소드를 기반으로 작동되는 barrier는 바로 꺼지는데, animation은 계속 진행되는 문제가 발생. 그래서 그 차이를 맞추기 위해 await + async를 써줌
      // forward 앞에는 await 안써줌. All activity 모달 창 열자마자 barrier 켜졌으면 해서. 근데 위로 올릴 때는 아님.
    }
    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All Activity"),
              Gaps.h6,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
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
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true,
              onDismiss: _toggleAnimation, //애니메이션 초기화시켜줌. 바탕화면 누르면 다시 모달 창이 올라감
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size5),
                  bottomRight: Radius.circular(Sizes.size5),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            tab["icon"],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h16,
                          Text(
                            tab["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
