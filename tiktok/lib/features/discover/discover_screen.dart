import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

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
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text('Discover'),
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size14,
            ),
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Sizes.size10,
              mainAxisSpacing: Sizes.size10,
              childAspectRatio: 9 / 20,
            ),
            itemBuilder: (context, index) => Column(
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: "assets/images/placeholder.jpg",
                      image:
                          "https://plus.unsplash.com/premium_photo-1667428818562-fc8379f23bfe?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=627&q=80"),
                ),
                Gaps.v10,
                const Text(
                  "This is a very long caption for my wooltok that i am uploading just now currently loading",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v8,
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 13,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1570654621852-9dd25b76b38d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
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
