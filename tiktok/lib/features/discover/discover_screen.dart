import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/breakpoints.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "Live",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Container(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: CupertinoSearchTextField(
              style: TextStyle(
                color: isDarkmode(context) ? Colors.white : Colors.black,
              ),
            ),
          ),
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size14,
            ),
            // 이건, 만약 main.dart에서 theme을 적용했는데도 불구하고 버그로 자동적용이 안되어있으면 강제적용시키는 코드.
            indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
            tabs: [
              for (var tab
                  in tabs) //PreferredSizedWidget을 넣을 수 있고, TabBar가 그것임.
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(children: [
          GridView.builder(
            //GridView child 쓰는 것보다 GirdView.builder 쓰는게 성능이 더 좋음.
            //child로 들어가면 모든 자식 위젯을 한꺼번에 build하므로 성능 저하. .builder믄 필요한 위젯만 빌드(지연 로딩)

            itemCount: 20,
            padding: const EdgeInsets.all(
              Sizes.size6,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width > Breakpoints.md ? 5 : 2,
              //화면 크기가 일정 수준 넘어가면 칼럼을 5개로 늘려줌. Widget of the week의 MediaQuery 영상 보십쇼
              crossAxisSpacing: Sizes.size10,
              mainAxisSpacing: Sizes.size10,
              childAspectRatio: 9 / 20,
            ),
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                      Sizes.size10,
                    )),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: "assets/images/placeholder.jpg",
                        image:
                            "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                      ),
                    ),
                  ),
                  Gaps.v10,
                  const Text(
                    "This is a very long caption for my wooltok that i am uploading just now currently loading",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  Gaps.v8,
                  if (constraints.maxWidth < 200 || constraints.maxWidth > 250)
                    DefaultTextStyle(
                      style: TextStyle(
                        color: isDarkmode(context)
                            ? Colors.grey.shade300
                            : Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 13,
                            backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/3612017",
                            ),
                          ),
                          Gaps.h4,
                          const Expanded(
                            child: Text(
                              "My Avartata is going to be very very long",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size16,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          const Text("2.5M")
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: const TextStyle(fontSize: Sizes.size16),
              ),
            )
        ]),
      ),
    );
  }
}
